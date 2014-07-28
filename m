From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] pwn: lpss: pci: move to use pcim_enable_device()
Date: Mon, 28 Jul 2014 15:07:32 +0300
Message-ID: <20140728120732.GL1857@lahna.fi.intel.com>
References: <1406298574-15857-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1406298574-15857-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33928 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaG1MHg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Jul 2014 08:07:36 -0400
Content-Disposition: inline
In-Reply-To: <1406298574-15857-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Fri, Jul 25, 2014 at 05:29:34PM +0300, Andy Shevchenko wrote:
> Let's use managed functions for this driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
