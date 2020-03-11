From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
Date: Wed, 11 Mar 2020 20:55:28 +0100
Message-ID: <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
 <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
 <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36773 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgCKTzc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 15:55:32 -0400
Content-Disposition: inline
In-Reply-To: <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: rishi gupta <gupt21@gmail.com>
Cc: thierry.reding@gmail.com, s.trumtrar@pengutronix.de, linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thu, Mar 12, 2020 at 01:16:28AM +0530, rishi gupta wrote:
> These 2 links contains more details:
> https://lore.kernel.org/patchwork/patch/732981
> https://lkml.org/lkml/2019/1/17/437

These are both about SIMPLE_DEV_PM_OPS which doesn't apply to
pwm-pca9685.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
