From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/5] clk: renesas: r8a7796: add PWM clock
Date: Thu, 20 Apr 2017 16:31:53 +0200
Message-ID: <CAMuHMdUA6u9BSOT97Fv9WzxtcrO0wXc3C9F+mTofES=gxB+dbg@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1492608293-12435-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1492608293-12435-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>
> This patch adds PWM clock for PWM.
>
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/clk/renesas/r8a7796-cpg-mssr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> index 9d114b3..be0fc00 100644
> --- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> @@ -151,6 +151,7 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
>         DEF_MOD("hscif1",                519,   R8A7796_CLK_S3D1),
>         DEF_MOD("hscif0",                520,   R8A7796_CLK_S3D1),
>         DEF_MOD("thermal",               522,   R8A7796_CLK_CP),
> +       DEF_MOD("pwm",                   523,   R8A7796_CLK_S3D4),

My copy of the R-Car Gen3 user manual rev. 0.53 says S0D12.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
