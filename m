From: Jes Sorensen <jes.sorensen@gmail.com>
Subject: Re: [PATCH v15 3/3] Input: new da7280 haptic driver
Date: Thu, 2 Jul 2020 14:01:55 -0400
Message-ID: <31377d96-3e6d-e7b6-30de-0c7e9e6f9364@gmail.com>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgGBSB7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2020 14:01:59 -0400
In-Reply-To: <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 6/29/20 9:01 AM, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> ---
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
>  drivers/input/misc/da7280.c | 1838 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1852 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c

[snip]

> +static ssize_t
> +patterns_store(struct device *dev,
> +	       struct device_attribute *attr,
> +	       const char *buf,
> +	       size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	char cmd[MAX_USER_INPUT_LEN];
> +	struct parse_data_t mem;
> +	unsigned int val;
> +	int error;
> +
> +	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> +	if (error)
> +		return error;
> +
> +	if (count > MAX_USER_INPUT_LEN)
> +		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
> +	else
> +		memcpy(cmd, buf, count);
> +
> +	/* chop of '\n' introduced by echo at the end of the input */
> +	if (cmd[count - 1] == '\n')
> +		cmd[count - 1] = '\0';

You have a potential memory corruption bug here for the case where
 count > MAX_USER_INPUT_LEN. The code correctly clamps the memcpy()
length, but it still is at risk of writing beyond the end of the cmd
buffer when doing the \0 termination.

If you change the code above to say

	if (count > MAX_USER_INPUT_LEN)
		count = MAX_USER_INPUT_LEN
	memcpy(cmd, buf, count);

it should take care of it, and it will also return the actual count
written to the caller.

Cheers,
Jes
