From: rishi gupta <gupt21@gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
Date: Sat, 21 Mar 2020 11:26:35 +0530
Message-ID: <CALUj-gs4=OP3qZEyZx_VahCTXQn7gcxAkvnc7Fb6UsaRzCLOig@mail.gmail.com>
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
 <20200311164449.flzzwxqqhcxisil3@pengutronix.de> <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
 <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43804 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCUF4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Mar 2020 01:56:48 -0400
In-Reply-To: <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, s.trumtrar@pengutronix.de, linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Tested again and found one gerrit was missing in my local build.
Both __maybe_unused and CONFIG_PM are working fine.

So it is your choice to apply or not apply this patch.

Regards,
Rishi

On Thu, Mar 12, 2020 at 1:25 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Mar 12, 2020 at 01:16:28AM +0530, rishi gupta wrote:
> > These 2 links contains more details:
> > https://lore.kernel.org/patchwork/patch/732981
> > https://lkml.org/lkml/2019/1/17/437
>
> These are both about SIMPLE_DEV_PM_OPS which doesn't apply to
> pwm-pca9685.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
