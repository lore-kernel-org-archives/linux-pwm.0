Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD8C47080
	for <linux-pwm@archiver.kernel.org>; Mon, 31 May 2021 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F2760BD3
	for <linux-pwm@archiver.kernel.org>; Mon, 31 May 2021 19:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEaTnh (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 31 May 2021 15:43:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:27843 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEaTng (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 15:43:36 -0400
IronPort-SDR: J1nEw5mOLJJaz2SwiEv0pgqC8NRosJWjOWtup+tCbiS4kujyMt2ptyMixcRevWC20RqWJN/q/g
 afnGuo7VckMA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183092446"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="183092446"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:41:55 -0700
IronPort-SDR: vfdwGRdSiUa3HfdJ7mSjoeHlEKf2Y7Saw7CxnURwBAmZrzonraTgmMchYbTgCwyLcD1Yx05HzV
 AoOGR6CvjwbA==
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="473996858"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:41:53 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lnnnK-00GBpr-DN; Mon, 31 May 2021 22:41:50 +0300
Date:   Mon, 31 May 2021 22:41:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/5] docs: firmware-guide: ACPI: Add a PWM example
Message-ID: <YLU7/mJ4dFTTWN5m@smile.fi.intel.com>
References: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
 <YLUKKeltfJe+4X2k@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLUKKeltfJe+4X2k@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 31, 2021 at 07:09:13PM +0300, Andy Shevchenko wrote:
> On Mon, May 31, 2021 at 06:43:47PM +0300, Andy Shevchenko wrote:
> > When PWM support for ACPI has been added into the kernel, it missed
> > the documentation update. Hence update documentation here.
> 
> I am actually in doubt that original commit message provides that short period
> intentionally. Possibly it was misinterpretation of nanoseconds (which is
> expected by PWM framework) with microseconds than might sound logical for LED.
> 
> Perhaps we may add 000 to the value (1) and replace us by ms in the text (2).

Okay, I will send an extended v2 and I think I will use 600 ms in the
documentation example.

-- 
With Best Regards,
Andy Shevchenko


