From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/4] pwm: lpss: Avoid potential overflow of base_unit
Date: Tue, 25 Oct 2016 12:33:35 +0300
Message-ID: <20161025093335.GE1476@lahna.fi.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
 <20161024144325.130353-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:13127 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754577AbcJYJfu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Oct 2016 05:35:50 -0400
Content-Disposition: inline
In-Reply-To: <20161024144325.130353-2-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Mon, Oct 24, 2016 at 05:43:22PM +0300, Andy Shevchenko wrote:
> The resolution of base_unit is derived from base_unit_bits and thus must be
> equal to (2^base_unit_bits - 1). Otherwise frequency and therefore base_unit
> might potentially overflow.
> 
> Prevent the above by substracting 1 in all cases where base_unit_bits or
> derevative is used.
  ^^^^^^^^^^
  derivative

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
