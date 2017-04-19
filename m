From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Wed, 19 Apr 2017 23:24:33 +0300
Message-ID: <20170419202433.GH2619@lahna.fi.intel.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com>
 <1492506852.24567.54.camel@linux.intel.com>
 <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44271 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936989AbdDSUYi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Apr 2017 16:24:38 -0400
Content-Disposition: inline
In-Reply-To: <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, Sven Van Asbroeck <TheSven73@googlemail.com>

On Tue, Apr 18, 2017 at 11:52:49AM -0400, Sven Van Asbroeck wrote:
> > __maybe_unused and remove ugly #ifdef:ery.
> 
> If this works on non- CONFIG_PM systems, I'm all for it !
> Grepping the drivers/ directory, I see that some drivers use
> #ifdef CONFIG_PM, some use __maybe_unused for runtime_pm.
> 
> Mika and Thierry, thoughts ?

I actually prefer CONFIG_PM here but up to Thierry to decide, I guess.
