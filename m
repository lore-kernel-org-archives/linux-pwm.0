From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/4] pwm: lpss: Allow duty cycle to be 0
Date: Tue, 25 Oct 2016 12:38:09 +0300
Message-ID: <20161025093809.GF1476@lahna.fi.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
 <20161024144325.130353-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27278 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758534AbcJYJiN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Oct 2016 05:38:13 -0400
Content-Disposition: inline
In-Reply-To: <20161024144325.130353-3-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Mon, Oct 24, 2016 at 05:43:23PM +0300, Andy Shevchenko wrote:
> A duty cycle is represented by values [0..<period>] which reflects [0%..100%].
> 0% of the duty cycle means always off (logical "0") on output. Allow this in
> the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
