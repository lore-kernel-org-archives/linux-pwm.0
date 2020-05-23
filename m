From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Date: Sat, 23 May 2020 23:05:25 +0200
Message-ID: <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbgEWVFa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 17:05:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1AC061A0E
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2020 14:05:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vineetha.g.jaya.kumaran@intel.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com

On Sun, May 17, 2020 at 09:52:38PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> In Keem Bay, the number of repetitions for the period/waveform
> can be configured from userspace. This requires addition of a sysfs
> attribute to get/set the repetition count. Setting this value to 0
> will result in continuous repetition of the waveform until the
> channel is disabled or reconfigured.

There is nothing specific for Keem Bay in this patch, the only special
thing here is that this driver is the first implementor.

IMHO all drivers that don't support count should be changed to fail if
a count > 0 is passed and introducing support in the sysfs interface
should be a separate change.

Having said that I'm not convinced this is a good idea given that only
very few driver can support this interface. Also this needs
documentation, e.g. what is expected from .get_state().

You should also motivate what this functionality is used for in the
commit log and I'd prefer to see an in-tree user (apart from sysfs which
I don't count as such).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
