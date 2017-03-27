From: Ilkka Koskinen <ilkka.koskinen@intel.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Mon, 27 Mar 2017 15:14:59 -0700
Message-ID: <20170327221459.GA105573@kammari>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490531124.708.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36210 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbdC0WOy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Mar 2017 18:14:54 -0400
Content-Disposition: inline
In-Reply-To: <1490531124.708.1.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

Hi,

On Sun, Mar 26, 2017 at 03:25:24PM +0300, Andy Shevchenko wrote:
> On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
> > Hi Andy, Thierry,
> > 
> > This patch fixes a regression with the pwm-lpss driver in 4.11,
> > where it once turned off will not turn back on again on some
> > machines. Yet it has been silent around this patch for some
> > time now. Can you please review this and get it queued as a fix
> > for 4.11 ?
> > 

Sorry, my bad. I thought I replied to this but obviously didn't.

> Hans, please, give me and Ilkka time to test this. It might appear that
> this fix breaks other platforms and we might need to introduce a quirk
> based on PCI ID. (Hope not)

While the patch seems ok, I have the same concern. 
 
> P.S. I will try to allocate time next week soonish for that.
> 
> Ilkka, can you do some tests on your side?

Unfortunately, I don't have a suitable device anymore as I changed the
team. However, I have asked a colleague to test the patch on BXT. He's
planning to do that this week.

Br, Ilkka
