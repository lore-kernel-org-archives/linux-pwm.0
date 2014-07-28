From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/2] pwm: lpss: properly split driver to parts
Date: Mon, 28 Jul 2014 18:34:11 +0300
Message-ID: <20140728153411.GO1857@lahna.fi.intel.com>
References: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1406559792-30652-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65268 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbaG1PeU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Jul 2014 11:34:20 -0400
Content-Disposition: inline
In-Reply-To: <1406559792-30652-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Mon, Jul 28, 2014 at 06:03:11PM +0300, Andy Shevchenko wrote:
> The driver consists core, PCI, and platform parts. It would better to split
> them into separate files.
> 
> The platform driver is now called pwm-lpss-platform. Thus, prevously set
> CONFIG_PWM_LPSS=m is not enough to build it. But we are on the safe side since
> it seems no one from outside Intel is using it for now.
> 
> While here, move to use macros module_pci_driver() and
> module_platform_driver().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me now,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
