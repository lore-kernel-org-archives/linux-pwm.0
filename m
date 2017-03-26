From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Sun, 26 Mar 2017 15:25:24 +0300
Message-ID: <1490531124.708.1.camel@linux.intel.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdCZM23 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Mar 2017 08:28:29 -0400
In-Reply-To: <20170325140658.26868-1-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
> Hi Andy, Thierry,
> 
> This patch fixes a regression with the pwm-lpss driver in 4.11,
> where it once turned off will not turn back on again on some
> machines. Yet it has been silent around this patch for some
> time now. Can you please review this and get it queued as a fix
> for 4.11 ?
> 

Hans, please, give me and Ilkka time to test this. It might appear that
this fix breaks other platforms and we might need to introduce a quirk
based on PCI ID. (Hope not)

P.S. I will try to allocate time next week soonish for that.

Ilkka, can you do some tests on your side?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
