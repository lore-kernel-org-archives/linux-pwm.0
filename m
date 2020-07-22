From: Jes Sorensen <jes.sorensen@gmail.com>
Subject: Re: [PATCH v16 3/3] Input: new da7280 haptic driver
Date: Wed, 22 Jul 2020 11:23:45 -0400
Message-ID: <bdc76da9-9223-b6d9-1fc1-2ef6e3b7afa7@gmail.com>
References: <cover.1594279649.git.Roy.Im@diasemi.com>
 <b02ba5b5dbd3d58f27440ba639d32e4405061df3.1594279649.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgGVPXt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jul 2020 11:23:49 -0400
In-Reply-To: <b02ba5b5dbd3d58f27440ba639d32e4405061df3.1594279649.git.Roy.Im@diasemi.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 7/9/20 3:27 AM, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> ---
> v16:
> 	- Corrected some code and updated description in Kconfig.
> v15:
> 	- Removed some defines and updated some comments.
> v14:
> 	- Updated pwm related code, alignments and comments.
> v13:
> 	- Updated some conditions in pwm function and alignments.
> v12: No changes.
> v11: 
> 	- Updated the pwm related code, comments and typo.
> v10: 
> 	- Updated the pwm related function and added some comments.
> v9: 
> 	- Removed the header file and put the definitions into the c file.
> 	- Updated the pwm code and error logs with %pE
> v8: 
> 	- Added changes to support FF_PERIODIC/FF_CUSTOM and FF_CONSTANT.
> 	- Updated the dt-related code.
> 	- Removed memless related functions.
> v7: 
> 	- Added more attributes to handle one value per file.
> 	- Replaced and updated the dt-related code and functions called.
> 	- Fixed error/functions.
> v6: No changes.
> v5: Fixed errors in Kconfig file.
> v4: Updated code as dt-bindings are changed.
> v3: No changes.
> v2: Fixed kbuild error/warning
> 
> 
>  drivers/input/misc/Kconfig  |   13 +
>  drivers/input/misc/Makefile |    1 +
>  drivers/input/misc/da7280.c | 1840 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1854 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c

Hi Roy,

Overall the driver looks pretty good now. I did find one issue, see
below. If you fix that I am happy to add a Reviewed-by line.

Reviewed-By: Jes Sorensen <Jes.Sorensen@gmail.com>

> diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> new file mode 100644
> index 0000000..c8c42ac
> --- /dev/null
> +++ b/drivers/input/misc/da7280.c

[snip]

> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain && enabled) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	if (enabled) {
> +		period_mag_multi = state.period * haptics->gain;

You are multiplying an unsigned int to a u16 and storing it in a u64.
However, C doesn't promote the types, so you'll end up with an
unexpected result here. You can fix it by promoting state.period to u64, ie:

		period_mage_multi = (u64)state.period * haptics->gain;

See the following example code which demonstrates the problem.

#include <stdio.h>
#include <stdint.h>

uint64_t foo(unsigned int a, uint16_t b)
{
	uint64_t tmp = a * b;
	return tmp;
}

uint64_t bar(unsigned int a, uint16_t b)
{
	uint64_t tmp = (uint64_t)a * b;
	return tmp;
}

int main()
{
	uint64_t val;
	unsigned int a = 0xff00ff00;
	uint16_t b = 0x200;

	val = foo(a, b);
	printf("result(%0x, %0x) = %0llx\n", a, b, val);

	val = bar(a, b);
	printf("result(%0x, %0x) = %0llx\n", a, b, val);
}

Cheers,
Jes
