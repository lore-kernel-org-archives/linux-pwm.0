From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/6] dt-bindings: pwm: renesas-tpu: Document r8a774[35] support
Date: Mon, 18 Dec 2017 11:58:28 +0100
Message-ID: <CAMuHMdUiyTL=Sw5Z-cxBq4zng27JHr7iCdvChkPxKQD7KVqvxg@mail.gmail.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com> <1513248976-26700-5-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36818 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbdLRK63 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Dec 2017 05:58:29 -0500
In-Reply-To: <1513248976-26700-5-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux PWM List <linux-pwm@vger.kernel.org>, devicetree@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Thu, Dec 14, 2017 at 11:56 AM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document r8a774[35] specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
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
