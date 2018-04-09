Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33594 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeDIIhj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Apr 2018 04:37:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
References: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 10:37:38 +0200
Message-ID: <CAMuHMdWt89M=kMVKFWj_1kT9ftTfmvZif1NS7E6Cahmc+62HEA@mail.gmail.com>
Subject: Re: [PATCH] pwm: rcar: simplify getting .drvdata
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Thu, Apr 5, 2018 at 7:25 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
