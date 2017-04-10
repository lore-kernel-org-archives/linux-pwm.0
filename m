From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: fix gpio-only operation.
Date: Mon, 10 Apr 2017 13:33:20 +0300
Message-ID: <20170410103320.GG2957@lahna.fi.intel.com>
References: <1491754284-3870-1-git-send-email-svenv@arcx.com>
 <1491754284-3870-2-git-send-email-svenv@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752941AbdDJKdf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Apr 2017 06:33:35 -0400
Content-Disposition: inline
In-Reply-To: <1491754284-3870-2-git-send-email-svenv@arcx.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>

On Sun, Apr 09, 2017 at 12:11:24PM -0400, Sven Van Asbroeck wrote:
> gpio-only driver operation never clears the SLEEP bit, which can
> cause the gpios to become unusable.
> 
> Example:
> 1. user requests first pwm  ->      driver clears SLEEP bit
> 2. user frees last pwm      ->      driver sets SLEEP bit
> 3. user requests gpio
> 4. user switches gpio on    ->      output does not turn on
>                                     because SLEEP bit is set
> 
> Prevent this behaviour by keeping the SLEEP bit cleared
> for the lifetime of the driver instance.
> 
> Fixes: bccec89f0a35 ("Allow any of the 16 PWMs to be used as a GPIO")
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>

How about implementing a real runtime PM in the driver? Then when the
device is idle regardless of whether it is GPIO or PWM, the SLEEP bit is
set and cleared accordingly.
