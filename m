From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM driver
Date: Tue, 25 Oct 2016 15:09:03 -0200
Message-ID: <CAOMZO5AS93=RhsDeJ99YV_01dbFAYidF4UY1hqgJh=AWEsqedw@mail.gmail.com>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <20161024173607.36bc2cb9@bbrezillon> <20161024232615.77d4ea28@jawa>
 <35a950b7ff431e0545bbb259ba69b483@agner.ch> <20161025090724.727c10bc@jawa> <CAOMZO5Bnfg43VY6tdsahCQ3PoVaL+wCzmPLCMTBK39FCHY9SpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34463 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcJYRJE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2016 13:09:04 -0400
In-Reply-To: <CAOMZO5Bnfg43VY6tdsahCQ3PoVaL+wCzmPLCMTBK39FCHY9SpQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Sascha Hauer <kernel@pengutronix.de>

On Tue, Oct 25, 2016 at 3:08 PM, Fabio Estevam <festevam@gmail.com> wrote:

>> the i.MX6q is not booting. Apparently I do need to wait for things to
>> calm down.
>
> Does this commit help with the boot issue you observed?

Sorry, missed to put the commit. Here it goes:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/mach-imx/gpc.c?id=eef0b282bb586259d35548851cf6a4ce847bb804
