From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/5] r8a7795/6 Salvator-X PWM enablement
Date: Thu, 20 Apr 2017 16:23:17 +0200
Message-ID: <CAMuHMdXX1Q8Fh07jkRvmVHmY3OBoSMbpFtByN2+KzSMfwAYq=A@mail.gmail.com>
References: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33509 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032639AbdDTOXf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 10:23:35 -0400
In-Reply-To: <1492608293-12435-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Uli,

On Wed, Apr 19, 2017 at 3:24 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This is a straight port from the BSP, enabling PWM1 and PWM2 on the
> Salvator-X boards. For r8a7796 it also adds the required infrastructure
> (clock and pins).
>
> Not fully tested because I cannot find my breakout adapter. Looks OK from
> the software side, though.

Did you manage to test it with the new "Easter bunny" adapter?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
