From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/6] dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
Date: Mon, 18 Dec 2017 11:57:17 +0100
Message-ID: <CAMuHMdVRvBk8SCNv5wWoLFf3ap9jQ6K--ytD93bmG=My+2ij5w@mail.gmail.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com> <1513248976-26700-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513248976-26700-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux PWM List <linux-pwm@vger.kernel.org>, devicetree@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 14, 2017 at 11:56 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch adds compatible strings specific to r8a774[35], no driver
> change is needed as the fallback compatible string will activate the
> right code. Also, this patch replaces the example with a DT snippet used
> for adding PWM0 support to an r8a7743 based platform.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
