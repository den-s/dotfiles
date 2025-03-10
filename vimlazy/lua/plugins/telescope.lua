local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')

vim.keymap.set('n', '<leader>b', function()
  builtin.buffers({
    -- initial_mode = "normal",
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection(function(selection)
          vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        end)
      end

      map('i', '<c-x>', delete_buf)

      return true
    end
  })
end)

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",    desc = "Grep (Root Dir)" },
    -- { "<leader>b",  "<cmd>Telescope buffers<cr>",      desc = "Grep (Opened Buffers)" },
    { "<leader>fc", "<cmd>Telescope git_bcommits<cr>", desc = "Grep (Git Commits)" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>",  desc = "Grep (String)" },
    { ";",          "<cmd>Telescope find_files<cr>",   desc = "Find Files (Root Dir)" },
  },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
    -- { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'MunifTanjim/nui.nvim' }
  },
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end

    require('telescope').load_extension('fzf')
    -- require("telescope").load_extension("ui-select")

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git" }
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then
        return { "where", "/r", ".", "*" }
      end
    end

    local Layout = require("nui.layout")
    local Popup = require("nui.popup")

    local telescope = require("telescope")
    local TSLayout = require("telescope.pickers.layout")

    local function make_popup(options)
      local popup = Popup(options)
      function popup.border:change_title(title)
        popup.border.set_text(popup.border, "top", title)
      end
      return TSLayout.Window(popup)
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        layout_strategy = "flex",
        vimgrep_arguments = vimgrep_arguments,
        layout_config = {
          horizontal = {
            size = {
              width = "90%",
              height = "60%",
            },
          },
          vertical = {
            size = {
              width = "90%",
              height = "90%",
            },
          },
          minimal = {
            size = {
              width = "50%",
              height = "70%",
            },
          },
        },
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["q"] = actions.close,
          },
        },
        create_layout = function(picker)
          local border = {
            results = {
              top_left = "┌",
              top = "─",
              top_right = "┬",
              right = "│",
              bottom_right = "",
              bottom = "",
              bottom_left = "",
              left = "│",
            },
            results_patch = {
              minimal = {
                top_left = "┌",
                top_right = "┐",
              },
              horizontal = {
                top_left = "┌",
                top_right = "┬",
              },
              vertical = {
                top_left = "├",
                top_right = "┤",
              },
            },
            prompt = {
              top_left = "├",
              top = "─",
              top_right = "┤",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            prompt_patch = {
              minimal = {
                bottom_right = "┘",
              },
              horizontal = {
                bottom_right = "┴",
              },
              vertical = {
                bottom_right = "┘",
              },
            },
            preview = {
              top_left = "┌",
              top = "─",
              top_right = "┐",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            preview_patch = {
              minimal = {},
              horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
              },
              vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = "│",
                top_left = "┌",
              },
            },
          }

          local results = make_popup({
            focusable = false,
            border = {
              style = border.results,
              text = {
                top = picker.results_title,
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local prompt = make_popup({
            enter = true,
            border = {
              style = border.prompt,
              text = {
                top = picker.prompt_title,
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local preview = make_popup({
            focusable = false,
            border = {
              style = border.preview,
              text = {
                top = picker.preview_title,
                top_align = "center",
              },
            },
          })

          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 1 }),
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = "col", size = "50%" }),
              Layout.Box(preview, { size = "50%" }),
            }, { dir = "row" }),
            minimal = Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
          }

          local function get_box()
            local strategy = picker.layout_strategy
            if strategy == "vertical" or strategy == "horizontal" then
              return box_by_kind[strategy], strategy
            end

            local height, width = vim.o.lines, vim.o.columns
            local box_kind = "horizontal"
            if width < 100 then
              box_kind = "vertical"
              if height < 40 then
                box_kind = "minimal"
              end
            end
            return box_by_kind[box_kind], box_kind
          end

          local function prepare_layout_parts(layout, box_type)
            layout.results = results
            results.border:set_style(border.results_patch[box_type])

            layout.prompt = prompt
            prompt.border:set_style(border.prompt_patch[box_type])

            if box_type == "minimal" then
              layout.preview = nil
            else
              layout.preview = preview
              preview.border:set_style(border.preview_patch[box_type])
            end
          end

          local function get_layout_size(box_kind)
            return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
          end

          local box, box_kind = get_box()
          local layout = Layout({
            relative = "editor",
            position = "50%",
            size = get_layout_size(box_kind),
          }, box)

          layout.picker = picker
          prepare_layout_parts(layout, box_kind)

          local layout_update = layout.update
          function layout:update()
            local box, box_kind = get_box()
            prepare_layout_parts(layout, box_kind)
            layout_update(self, { size = get_layout_size(box_kind) }, box)
          end

          return TSLayout(layout)
        end,
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
          -- layout_strategy = 'horizontal',
          -- theme = "dropdown",
        },
        leave_grep = {
          -- layout_strategy = 'horizontal',
          -- theme = "dropdown",
        },
        buffers = {
          layout_strategy = 'vertical',
          layout_config={
            vertical = {
              size = {
                width='60%',
                height='80%'
              }
            }
          }
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
      },
      extensions = {
        fzf = {
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },
        -- ["ui-select"] = {
        --   require("telescope.themes").get_dropdown {
        --     -- even more opts
        --   }
        -- },
      },
    }
  end,
}
