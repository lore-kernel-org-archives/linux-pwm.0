From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Date: Sat, 23 May 2020 22:17:30 +0200
Message-ID: <20200523201730.o7y7pent4hjtgia3@pengutronix.de>
References: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
 <20190606151111.14237-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbgEWURk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 16:17:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCABC061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 13:17:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190606151111.14237-1-TheSven73@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jun 06, 2019 at 11:11:11AM -0400, Sven Van Asbroeck wrote:
> I was able to test the patch [1] exclusion mechanism without access to actual
> hardware - by giving it a dummy regmap. See patch below.
> 
> Test cases (all via sysfs):
> 1. verify requested pwm cannot be requested as gpio
> 2. verify requested gpio cannot be requested as pwm
> 3. verify pwm "all LEDs" cannot be used if pwms/gpios in use
> 4. verify pwms/gpios cannot be requested if pwm "all LEDs" in use
> 
> All test cases ok.
>  Obviously, I could not test multi-threaded correctness.
> 
> [1] https://lkml.org/lkml/2019/6/4/1039

Is this patch still relevant? A patch similar to YueHaibing's one was
merged in the meantime but I guess the underlying problem is still
relevant. Sven, do you care enough to recheck and create a patch on top
of a more recent tree?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
