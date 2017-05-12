From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4] dt-bindings: pwm: Add R-Car M3-W device tree bindings
Date: Fri, 12 May 2017 10:11:53 +0200
Message-ID: <CAMuHMdXL+T7DkgtG2DLmVvmmYE0=cG6xP9tijNWEm2bmq3c_sA@mail.gmail.com>
References: <1494576582-17881-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34845 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdELILz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2017 04:11:55 -0400
In-Reply-To: <1494576582-17881-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On Fri, May 12, 2017 at 10:09 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>
> Add device tree bindings for the PWM controller found on R-Car M3-W SoCs.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> v4
> * Broke out of lager patchset on which it appears to have no dependencies
> * Added Reviewed by tags

Really? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
