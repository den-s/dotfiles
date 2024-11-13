local status_ok, kanagawa = pcall(require, "kanagawa")
if not status_ok then
	return
end

kanagawa.setup({
  theme = "wave",
    background = {
        dark = "wave",
        light = "lotus"
    },
})

kanagawa.load("wave")
