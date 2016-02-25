From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] pwm: rcar: Use ARCH_RENESAS
Date: Thu, 25 Feb 2016 09:41:35 +0100
Message-ID: <CAMuHMdVSZEyLh-U=JyvkaCr2cDwdxKLj0hnCsY+gnYAT-h4upQ@mail.gmail.com>
References: <1456362203-21038-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36431 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760103AbcBYIlg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Feb 2016 03:41:36 -0500
In-Reply-To: <1456362203-21038-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org

On Thu, Feb 25, 2016 at 2:03 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
