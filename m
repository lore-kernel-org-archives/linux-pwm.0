From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Wed, 19 Oct 2016 21:56:38 +0300
Message-ID: <20161019185638.GP1722@lahna.fi.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54744 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932669AbcJSS4m (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 Oct 2016 14:56:42 -0400
Content-Disposition: inline
In-Reply-To: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> The PCA9685 controller has full on/off bit for each PWM channel. Setting
> this bit bypasses the PWM control and the line works just as it would be a
> GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
> discreet muxes on the board.
> 
> This patch adds GPIO output only support for the driver so that we can
> control the muxes on Galileo using standard GPIO interfaces available in
> the kernel. GPIO and PWM functionality is exclusive so only one can be
> active at a time on a single PWM channel.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thierry,

Any comments on this?
