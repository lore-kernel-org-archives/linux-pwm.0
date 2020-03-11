From: rishi gupta <gupt21@gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
Date: Thu, 12 Mar 2020 01:16:28 +0530
Message-ID: <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com> <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38375 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgCKTql (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 15:46:41 -0400
In-Reply-To: <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, s.trumtrar@pengutronix.de, linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

These 2 links contains more details:
https://lore.kernel.org/patchwork/patch/732981
https://lkml.org/lkml/2019/1/17/437

On Wed, Mar 11, 2020 at 10:14 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Mar 11, 2020 at 09:13:49PM +0530, Rishi Gupta wrote:
> > The __maybe_unused attribute is preferred over CONFIG_PM
> > to prevent build time issues. This commit replaces CONFIG_PM
> > with this attribute.
>
> I wasn't aware of build time issues and thought this was just about
> #ifdef being ugly.
>
> Anyhow, the change is fine,
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
