From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] pwm: pca9685: fix pwm/gpio inter-operation
Date: Wed, 5 Jun 2019 15:53:56 +0300
Message-ID: <20190605125356.GI2781@lahna.fi.intel.com>
References: <20190604181345.9107-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604181345.9107-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 04, 2019 at 02:13:45PM -0400, Sven Van Asbroeck wrote:
> This driver allows pwms to be requested as gpios via gpiolib.
> Obviously, it should not be allowed to request a gpio when its
> corresponding pwm is already requested (and vice versa).
> So it requires some exclusion code.
> 
> Given that the pwm and gpio cores are not synchronized with
> respect to each other, this exclusion code will also require
> proper synchronization.
> 
> Such a mechanism was in place, but was inadvertently removed
> by Uwe's clean-up patch.
> 
> Upon revisiting the synchronization mechanism, we found that
> theoretically, it could allow two threads to successfully
> request conflicting pwms / gpios.
> 
> Replace with a bitmap which tracks pwm in-use, plus a mutex.
> As long as pwm and gpio's respective request/free functions
> modify the in-use bitmap while holding the mutex, proper
> synchronization will be guaranteed.
> 
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
