From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/6] arm64: dts: r8a7795: Add PWM device nodes
Date: Thu, 24 Mar 2016 14:52:09 +0100
Message-ID: <CAMuHMdUzD91D+DJUycy09gaMJYm_XkDTx1ux+6g9xznu-W89Pw@mail.gmail.com>
References: <1457542562-7880-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1457542562-7880-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1457542562-7880-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
List-Id: linux-pwm@vger.kernel.org

Hi Ulrich,

On Wed, Mar 9, 2016 at 5:55 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> [uli: adapted to new MSTP clock scheme]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 5367a7b..531e3b6 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -618,6 +618,60 @@
>                         status = "disabled";
>                 };
>
> +               pwm1: pwm@e6e31000 {

Any specific reason pwm0 is not included?

Apart from that
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
