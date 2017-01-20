From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can find the
 pwm_backlight
Date: Fri, 20 Jan 2017 11:55:19 +0200
Message-ID: <20170120095519.GF17297@lahna.fi.intel.com>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec>
 <8737gei2fp.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:60156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbdATKEI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Jan 2017 05:04:08 -0500
Content-Disposition: inline
In-Reply-To: <8737gei2fp.fsf@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-pwm@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Fri, Jan 20, 2017 at 10:02:50AM +0200, Jani Nikula wrote:
> That said, I suppose there could be an alternative to handling pwm_get()
> failures at probe. We could just go on with our init, but schedule a
> retry later. Perhaps a bit hacky, but it would address both of the
> concerns above. Again, this patch seems a simple workaround in the mean
> time.

Not sure if this works or how hacky it is, but can't you
request_module() before you start looking up for the pwm?
