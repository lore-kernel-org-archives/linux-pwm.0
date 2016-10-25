From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 4/4] pwm: lpss: Switch to new atomic API
Date: Tue, 25 Oct 2016 12:39:36 +0300
Message-ID: <20161025093936.GG1476@lahna.fi.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
 <20161024144325.130353-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965633AbcJYJjp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Oct 2016 05:39:45 -0400
Content-Disposition: inline
In-Reply-To: <20161024144325.130353-5-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Mon, Oct 24, 2016 at 05:43:25PM +0300, Andy Shevchenko wrote:
> Instead of doing things separately, which is not so reliable on some platforms,
> switch the driver to use new atomic API, i.e. ->apply() callback.
> 
> The change has been tested on Intel platforms such as Broxton, BayTrail, and
> Merrifield.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
