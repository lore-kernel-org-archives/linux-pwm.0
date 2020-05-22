From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Date: Fri, 22 May 2020 11:32:33 +0200
Message-ID: <20200522093233.yy3tcalveoutxcsj@pengutronix.de>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <20200522091824.GR1634618@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEVJcj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 05:32:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539FC061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 02:32:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200522091824.GR1634618@smile.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>, thierry.reding@gmail.com, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com

Hello Andy,

On Fri, May 22, 2020 at 12:18:24PM +0300, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 10:56:13AM +0200, Uwe Kleine-König wrote:
> > On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
> 
> > > +	io_base = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(io_base))
> > 
> > error message here?
> 
> platform core provides it. No need to duplicate (esp. taking into consideration
> that it can issue IIRC three different error messages depending on actual error).

Ah, missed that. Indeed that's fine as is in the patch.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
