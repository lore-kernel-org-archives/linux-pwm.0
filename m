From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 13 Apr 2017 11:15:55 +0300
Message-ID: <20170413081555.GC3473@lahna.fi.intel.com>
References: <1492010159-6050-1-git-send-email-svenv@arcx.com>
 <1492010159-6050-2-git-send-email-svenv@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492010159-6050-2-git-send-email-svenv@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 12, 2017 at 11:15:59AM -0400, Sven Van Asbroeck wrote:
> +	pm_runtime_set_active(&client->dev);
> +	/* enable will put the chip into suspend, which is what we
> +	 * want as all outputs are disabled at this point
> +	 */

This comment should also be in the standard block comment format.

Other than that, the patch looks good to me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
