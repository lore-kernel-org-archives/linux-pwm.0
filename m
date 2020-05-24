From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Date: Sun, 24 May 2020 12:21:19 +0200
Message-ID: <20200524102119.2fzcl7bqu6qh3w5g@pengutronix.de>
References: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
 <20190606151111.14237-1-TheSven73@gmail.com>
 <20200523201730.o7y7pent4hjtgia3@pengutronix.de>
 <CAGngYiWCT=_H+PwXRTgMWRpwRWMrgvA3vD1is2r704oZn14LiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgEXKVa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 06:21:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C03C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 03:21:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGngYiWCT=_H+PwXRTgMWRpwRWMrgvA3vD1is2r704oZn14LiA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 23, 2020 at 08:24:23PM -0400, Sven Van Asbroeck wrote:
> Hi Uwe,
> 
> On Sat, May 23, 2020 at 4:17 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Is this patch still relevant?
> 
> A slightly different version of this patch has already landed in
> mainline. Clemens Gruber had
> relevant hardware available, and was able to test it out.
> 
> See Linus's tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pwm/pwm-pca9685.c?h=v5.7-rc6&id=9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2

Optimal, thanks for the feedback. So this thread can be closed.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
