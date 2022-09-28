Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D05C54EE9
	for <linux-pwm@archiver.kernel.org>; Wed, 28 Sep 2022 14:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiI1Opj (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiI1Opa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 10:45:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F338B2;
        Wed, 28 Sep 2022 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664376327; x=1695912327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJoaWQV+GfSnfR3aK+SXucd83SNX/yJoQ2eac0XfQGw=;
  b=A9tUEcqvXAkHMJwsgTLAH9KCFd95KCeAhxjB364MA7jHThYbkMbRYOyR
   9RtDylMl9HCHl0TqFJwStFJqxJjCvyTXBJPuhWvgb+JmxwLJH8df0eSvW
   W0YQ2cAdPZn88nbvVJUgU08jvJ70bxv1cuD6N7V7/V2asttjrjP0KGq/q
   W3EpWFAWH05WLZTZNywAsgsFvyhKv5dHPrSv2kaTPlL25CummUzSRFsad
   U2mDAAS5dmCDxRQwwHSwT1Qz0GvrIAcfrgwcxB3Mi9BWr6AACHcYqQ3FT
   G0Qc37U8rx91Y6+/X2qhqcJV5CJUAlMyhOEHaDMrVs1oemRlCwyodABQ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="327986207"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="327986207"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684432167"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="684432167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2022 07:45:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odYJM-008yFB-1t;
        Wed, 28 Sep 2022 17:45:20 +0300
Date:   Wed, 28 Sep 2022 17:45:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] pwm: lpss: Clean up and convert to a pure library
Message-ID: <YzReAPJpyL66XDON@smile.fi.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
 <YzRYmtcsdW6iSC0L@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRYmtcsdW6iSC0L@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 28, 2022 at 04:22:18PM +0200, Thierry Reding wrote:
> On Tue, Sep 27, 2022 at 07:24:14PM +0300, Andy Shevchenko wrote:
> > First of all, a set of cleanups and code deduplications (for better
> > maintenance) to the PWM LPSS driver.
> > 
> > Second, we may (re-)use the core part as a library in the future in
> > the devices that combine the same PWM IP in their address space. So
> > convert the core file to be a pure library which doesn't require any
> > special resource handling or alike.

> Series applied, thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


