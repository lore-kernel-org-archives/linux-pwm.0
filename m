From: Ilkka Koskinen <ilkka.koskinen@intel.com>
Subject: Re: [PATCH v3 1/2] pwm: lpss: Split Tangier configuration
Date: Mon, 10 Apr 2017 11:31:32 -0700
Message-ID: <20170410183132.GA22471@kammari>
References: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12544 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbdDJSdB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Apr 2017 14:33:01 -0400
Content-Disposition: inline
In-Reply-To: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Apr 06, 2017 at 02:54:00PM +0300, Andy Shevchenko wrote:
> As a preparation for special treatment for Broxton we split Tangier
> configuration.
> 
> Fixes: b89b4b7a3d0a ("pwm: lpss: pci: Enable PWM module on Intel Edison")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, Andy! Both patches look good to me.

Br, Ilkka
