Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636623;
	b=eF00BhTeXnsC5kyGpIkJ4RU3r2rTbSevgTzeKBjLGPFgynmflseeEwsOUN6fz+naqVYE
	 RR/bDLYua8oSG1BDhtBerpd0BJFM5xA1aMmyCc4ok45YYXxjZmgfhvX1Q9yckwKEN9+k1
	 1o8wNmMZf7LmpJYTqEyFPsQdOjcwyMQY3Ir3mMFxLxEqvZe8KIyR5NsOs1o99Cmm22Nfp
	 KTUEpnRGtVt7fZ3Mq5VC4ZEbfEo81Z5EWSqPBPGeMVFWZvj8lM5QzatlIR4+N1osIFbdi
	 LyUJgEaD5qU/1nhqMGkZN8ILyrLpQQs/eWcawAQEPflq5vBXshSVCujH698MzOiJyxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636623;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=PXbLdbPvzm0soWnWBNnafvLzqYuqPA3azET1IzPc694=;
	b=J3Q21lQuY3ICMaw1XTBrXk/4ufRdaB4z/gGQuiXurm5Dddybs5t3hFNfkad3D3EXgdJs
	 b2hFBecOKl7EggetTwbKZgHREemLvsUruPMYaTY2PKI/egZMm1cOKeQBhC/4WnGQnPfYR
	 +ZBlQMMS8OiW1M+tY8751p/dly7Gl9QrS37Mhfof6mL/5VrMeBvRm/vz2syKidADt+E51
	 RIBOWijLO/dllxR7mj9vG1v+3ES02QZBGkyMGPzJV2mmq5qq+GfTXfyI5CT4EyrmBo8jY
	 9/1q5IfL+yZvLllijX672LIuE4tX4v/IrqEWp7Tl0atqyvbV3sMbVYtdOSMJ8n0M6Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=B4Qc5vpu;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFE606A336
	for <linux-pwm@vger.kernel.org>; Sat, 14 Nov 2026 06:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6AFE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=B4Qc5vpu
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id S0FixFQDn4vCDS6xsxy23Z; Sat, 14 Nov 2026 06:10:16 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id S6xrxdNPCxmi7S6xsxsifI; Sat, 14 Nov 2026 06:10:16 +0000
X-Authority-Analysis: v=2.4 cv=KuFN2XWN c=1 sm=1 tr=0 ts=6af7fb48
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=TjzAy5JSDq1FJsndYscA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=PXbLdbPvzm0soWnWBNnafvLzqYuqPA3azET1IzPc694=; b=B4Qc5vpuNIMa
	gLYhtjn4TFDfWOsxcSmkB7F2Q74lPmcvyqMVwM+AnqPK9qeCtbw3vc7h+DnadN+SJUfeYzU29PuT/
	xifgTIWJ/2g3nFsxs/o1Sx0V4kXkRJQdgyi1u8YbFPiTQl2I+31kf1RpQETQxJaDJDW8pW2cYhTP6
	7Ybdoi1H4vobwl7kz92Cf83Nfh0mxwWHlKVMI0rZY9jgLZO5gwTG/4mFP/KjNW8dFXqcPI95CbDev
	qRr0mFwWNpappgqe3xzPJISdZ/zOBXLFpVzvYeCRf8ZWZgt0PYwSr/MfCr057yjdwGiQ31OH3Sjjf
	FJcWc0VgpWLiIZ6+sq1Atw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33908)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xS6xr-000000049GL-0zFr;
	Sat, 14 Nov 2026 11:40:15 +0530
Message-ID: <3a70c6bd-7660-4b44-9895-3626a6382d67@roeck-us.net>
Date: Fri, 13 Nov 2026 22:10:13 -0800
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hwmon: (adt7475) Expose fan control via PWM framework
To: =?UTF-8?Q?Dav=C3=AD=C3=B0_Steinn_Geirsson?= <david@dsg.is>,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261114004110.328050-1-david@dsg.is>
 <20261114004110.328050-5-david@dsg.is>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261114004110.328050-5-david@dsg.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xS6xr-000000049GL-0zFr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:33908
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 20
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpzQxbS7PLWP4Pyt+WCE6s8vd9ojPKbQKMJj1vN2JcetxaYzJL07ZRDeyoNdv52watn/fF0hn9egSzdV4a9SGydLFfh6Hy2rSgi+nIUQCxJaKlXclqk
 5AEnTqVnkvVpFPk9lVYIDL51uP4FG27wvd7fWa3rJfyukbN1mbXrKTX8a7LHTP9qoJ8YX2gZ6Q+Sq2P4RIEnA1A/HUZR+148uH89qOIn2aKiUENcdqCSjEtg

On 11/13/26 16:41, Davíð Steinn Geirsson wrote:
> Register the PWM outputs with the PWM framework when the node has
> "#pwm-cells", so that generic consumers such as pwm-fan can drive them,
> for example as thermal cooling devices. This follows the ADT7470
> driver. A failure to register the PWM chip fails the probe. Without
> CONFIG_PWM, no PWM chip is registered. Unlike ADT7470, the driver does
> not warn about "#pwm-cells" without CONFIG_PWM: fan-N children use the
> property too, so its presence does not imply a PWM consumer.
> CONFIG_PWM is bool, so no Kconfig dependency is needed.
> 
> The binding also documents "#pwm-cells" without a PWM consumer: fan-N
> child nodes reference the chip itself to configure a channel at probe.
> Device trees that do this keep working unchanged. Registering the PWM
> chip does not touch the hardware, and requesting a channel only marks
> it as held. Nothing changes for a channel until a consumer applies a
> waveform to it.
> 
> The driver implements the waveform callbacks:
> * The period selects the longest supported period that does not exceed
>    the request. The periods are 1 s divided by the table frequency,
>    rounded down, so 44444 ns selects 22.5 kHz exactly. A shorter period
>    is rounded up to 44444 ns. pwm_set_waveform_might_sleep() applies
>    that unless an exact match is requested; pwm_apply_might_sleep()
>    rejects it with -EINVAL.
> * The duty cycle is the high time in 1/255 steps of that period, rounded
>    down. The duty offset is always 0.
> * Writing an enabled waveform puts the channel in manual mode, clears
>    the output inversion bit and writes the duty cycle and the per-channel
>    frequency. Once a consumer has enabled a channel, the consumer's
>    polarity flags therefore replace "adi,pwm-active-state" and the fan-N
>    flags for that channel.
> * A disabled waveform gives duty 0 (constant low) on a channel in manual
>    mode, and leaves a channel in any other mode alone.
> * An I2C error is returned to the PWM core. The hwmon register cache
>    follows each successful register write, so pwmN_enable reports manual
>    mode (1) once a consumer has enabled the channel.
> * Reading returns the hardware state. A channel that is not in manual
>    mode is not driven by the PWM framework and reads as disabled, so a
>    consumer's first enabled request always differs from the read-back
>    state and is never skipped by the core. An inverted output reads as
>    its high time.
> 
> While a consumer holds a channel, writes to that channel's pwmN,
> pwmN_enable, pwmN_freq, pwmN_auto_channels_temp,
> pwmN_auto_point{1,2}_pwm and pwmN_stall_disable fail with -EBUSY, so
> userspace cannot fight the kernel. The attributes stay readable. The
> other channels and the temperature-based auto points stay writable: the
> auto points only matter in automatic mode, and other channels may use
> them.
> 
> The ADT7470 driver hides its PWM attributes when "#pwm-cells" is
> present. This driver returns -EBUSY instead:
> * The ADT7475 binding has documented "#pwm-cells" for fan-N children
>    since v6.12. Device trees that follow it must keep their attributes.
>    No in-tree device tree uses "#pwm-cells" on these chips today.
> * Attribute visibility is fixed when the hwmon device registers, but a
>    channel is only held once a consumer requests it, after the attributes
>    exist.
> 
> Document the PWM provider in adt7475.rst.
> 
> Signed-off-by: Davíð Steinn Geirsson <david@dsg.is>
> ---
> This patch was written with Claude Code, using the models Claude
> Opus 5.5 and Claude Fable 5.2. They wrote the code and the initial
> commit message draft, which I cleaned up. I directed the design,
> reviewed the result, compared against the datasheet as far as I
> could, and ran tests including on actual hardware.
> 
>   Documentation/hwmon/adt7475.rst |  15 ++
>   drivers/hwmon/adt7475.c         | 319 ++++++++++++++++++++++++++++++--
>   2 files changed, 322 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/hwmon/adt7475.rst b/Documentation/hwmon/adt7475.rst
> index b5976e3ff3d4..0a864adda5e0 100644
> --- a/Documentation/hwmon/adt7475.rst
> +++ b/Documentation/hwmon/adt7475.rst
> @@ -152,6 +152,21 @@ The responsiveness of the ADT747x to temperature changes can be configured.
>   This allows smoothing of the fan speed transition. To set the transition time
>   set the value in ms in the `temp[1-*]_smoothing` sysfs attribute.
>   
> +PWM Provider
> +------------
> +
> +With CONFIG_PWM enabled and a ``#pwm-cells`` property in the device node, the
> +driver registers the PWM outputs as a PWM chip, so that a consumer such as
> +``pwm-fan`` can drive them.
> +
> +While a consumer holds a channel, writes to that channel's ``pwmN``,
> +``pwmN_enable``, ``pwmN_freq``, ``pwmN_auto_channels_temp``,
> +``pwmN_auto_point[12]_pwm`` and ``pwmN_stall_disable`` attributes fail with
> +-EBUSY. Reads still work. Once a consumer has enabled a channel, the channel
> +is in manual mode and ``pwmN_enable`` reads 1. When the consumer releases the
> +channel, the attributes become writable again and the channel keeps its last
> +mode and duty cycle.
> +
>   Notes
>   -----
>   
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 73c19c10bb34..6577a73f71a7 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -18,8 +18,10 @@
>   #include <linux/hwmon-vid.h>
>   #include <linux/err.h>
>   #include <linux/jiffies.h>
> +#include <linux/math64.h>
>   #include <linux/of.h>
>   #include <linux/property.h>
> +#include <linux/pwm.h>
>   #include <linux/util_macros.h>
>   
>   #include <dt-bindings/pwm/pwm.h>
> @@ -219,6 +221,7 @@ struct adt7475_data {
>   	u8 pwmctl[3];
>   	u8 pwmchan[3];
>   	u8 enh_acoustics[2];
> +	u8 pwm_held;		/* Channels requested through the PWM framework */
>   
>   	u8 vid;
>   	u8 vrm;
> @@ -668,14 +671,32 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>   	return sprintf(buf, "%d\n", data->pwm[sattr->nr][sattr->index]);
>   }
>   
> -static void adt7475_pwm_set(struct adt7475_data *data, int nr, int index,
> -			    long val)
> +/*
> + * Writes to the hwmon attributes of a PWM channel fail while a PWM consumer
> + * holds it. Call with data->lock held.
> + */
> +static int adt7475_pwm_check_held(struct adt7475_data *data, int index)
> +{
> +	lockdep_assert_held(&data->lock);

All calling code first acquires this mutex. Checking here if it is held
is pointless. I am not a friend of such pointless checks. Please drop.

Also, the function name is a bit confusing. It suggests that the code
would check if the mutex is held. Please find a better name.

Thanks,
Guenter

> +
> +	return data->pwm_held & BIT(index) ? -EBUSY : 0;
> +}
> +
> +static int adt7475_pwm_set(struct adt7475_data *data, int nr, int index,
> +			   long val)
>   {
>   	struct i2c_client *client = data->client;
>   	unsigned char reg = 0;
> +	int ret;
>   
>   	mutex_lock(&data->lock);
>   
> +	ret = adt7475_pwm_check_held(data, index);
> +	if (ret) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
>   	switch (nr) {
>   	case INPUT:
>   		/* Get a fresh value for CONTROL */
> @@ -688,7 +709,7 @@ static void adt7475_pwm_set(struct adt7475_data *data, int nr, int index,
>   		 */
>   		if (((data->pwm[CONTROL][index] >> 5) & 7) != 7) {
>   			mutex_unlock(&data->lock);
> -			return;
> +			return 0;
>   		}
>   
>   		reg = PWM_REG(index);
> @@ -706,6 +727,8 @@ static void adt7475_pwm_set(struct adt7475_data *data, int nr, int index,
>   	data->pwm[nr][index] = clamp_val(val, 0, 0xFF);
>   	i2c_smbus_write_byte_data(client, reg, data->pwm[nr][index]);
>   	mutex_unlock(&data->lock);
> +
> +	return 0;
>   }
>   
>   static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
> @@ -714,13 +737,14 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
>   	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
>   	struct adt7475_data *data = dev_get_drvdata(dev);
>   	long val;
> +	int ret;
>   
>   	if (kstrtol(buf, 10, &val))
>   		return -EINVAL;
>   
> -	adt7475_pwm_set(data, sattr->nr, sattr->index, val);
> +	ret = adt7475_pwm_set(data, sattr->nr, sattr->index, val);
>   
> -	return count;
> +	return ret ? ret : count;
>   }
>   
>   static ssize_t stall_disable_show(struct device *dev,
> @@ -749,6 +773,11 @@ static ssize_t stall_disable_store(struct device *dev,
>   
>   	mutex_lock(&data->lock);
>   
> +	if (adt7475_pwm_check_held(data, sattr->index)) {
> +		mutex_unlock(&data->lock);
> +		return -EBUSY;
> +	}
> +
>   	data->enh_acoustics[0] &= ~mask;
>   	if (val)
>   		data->enh_acoustics[0] |= mask;
> @@ -1111,22 +1140,30 @@ static int adt7475_pwm_write(struct device *dev, u32 attr, int channel,
>   
>   	switch (attr) {
>   	case hwmon_pwm_input:
> -		adt7475_pwm_set(data, INPUT, channel, val);
> +		ret = adt7475_pwm_set(data, INPUT, channel, val);
>   		break;
>   
>   	case hwmon_pwm_enable:
>   		mutex_lock(&data->lock);
> -		/* Read Modify Write PWM values */
> -		adt7475_read_pwm(client, channel);
> -		ret = hw_set_pwm(client, channel, val, data->pwmchan[channel]);
> +		ret = adt7475_pwm_check_held(data, channel);
> +		if (!ret) {
> +			/* Read Modify Write PWM values */
> +			adt7475_read_pwm(client, channel);
> +			ret = hw_set_pwm(client, channel, val,
> +					 data->pwmchan[channel]);
> +		}
>   		mutex_unlock(&data->lock);
>   		break;
>   
>   	case hwmon_pwm_auto_channels_temp:
>   		mutex_lock(&data->lock);
> -		/* Read Modify Write PWM values */
> -		adt7475_read_pwm(client, channel);
> -		ret = hw_set_pwm(client, channel, data->pwmctl[channel], val);
> +		ret = adt7475_pwm_check_held(data, channel);
> +		if (!ret) {
> +			/* Read Modify Write PWM values */
> +			adt7475_read_pwm(client, channel);
> +			ret = hw_set_pwm(client, channel,
> +					 data->pwmctl[channel], val);
> +		}
>   		mutex_unlock(&data->lock);
>   		break;
>   
> @@ -1136,6 +1173,12 @@ static int adt7475_pwm_write(struct device *dev, u32 attr, int channel,
>   
>   		mutex_lock(&data->lock);
>   
> +		ret = adt7475_pwm_check_held(data, channel);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +
>   		data->range[channel] =
>   			adt7475_read(TEMP_TRANGE_REG(channel));
>   		data->range[channel] &= ~0xf;
> @@ -1804,6 +1847,250 @@ static int adt7475_fan_pwm_config(struct i2c_client *client)
>   	return 0;
>   }
>   
> +/*
> + * PWM framework provider. Requesting a channel only marks it held: the
> + * hardware is left alone until the consumer applies a state.
> + *
> + * Limitations:
> + * - Only the fixed periods of pwmfreq_table (11 Hz to 22.5 kHz) are
> + *   supported. The duty cycle is set in 1/255 steps of the period.
> + * - The duty offset is not supported and is always 0.
> + * - Disabling a channel in manual mode sets its duty cycle to 0, so the
> + *   output is constant low. A channel in any other mode is left alone.
> + * - Mode, duty cycle and frequency are separate register writes, in that
> + *   order. An update is not atomic, and the output can briefly run with
> + *   a mix of old and new settings.
> + */
> +static int adt7475_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct adt7475_data *data = pwmchip_get_drvdata(chip);
> +
> +	/* The PWM2 pin is the SMBALERT# output */
> +	if (pwm->hwpwm == 1 && !data->has_pwm2)
> +		return -ENODEV;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_held |= BIT(pwm->hwpwm);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static void adt7475_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct adt7475_data *data = pwmchip_get_drvdata(chip);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_held &= ~BIT(pwm->hwpwm);
> +	mutex_unlock(&data->lock);
> +}
> +
> +/*
> + * The waveform API has no polarity: duty is the high time in 1/255 steps of
> + * the period.
> + */
> +struct adt7475_pwm_wfhw {
> +	bool enabled;
> +	u8 duty;
> +	u8 freq_idx;	/* Index into pwmfreq_table */
> +};
> +
> +static u64 adt7475_pwm_period(int freq_idx)
> +{
> +	return NSEC_PER_SEC / pwmfreq_table[freq_idx];
> +}
> +
> +static int adt7475_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct adt7475_pwm_wfhw *wfhw = _wfhw;
> +	u64 period;
> +	int i;
> +
> +	if (!wf->period_length_ns) {
> +		*wfhw = (struct adt7475_pwm_wfhw){ .enabled = false };
> +		return 0;
> +	}
> +
> +	/* The longest supported period that does not exceed the request */
> +	for (i = 0; i < ARRAY_SIZE(pwmfreq_table) - 1; i++)
> +		if (adt7475_pwm_period(i) <= wf->period_length_ns)
> +			break;
> +	period = adt7475_pwm_period(i);
> +
> +	wfhw->enabled = true;
> +	wfhw->freq_idx = i;
> +	if (wf->duty_length_ns >= period)
> +		wfhw->duty = 0xFF;
> +	else
> +		wfhw->duty = mul_u64_u64_div_u64(wf->duty_length_ns, 0xFF,
> +						 period);
> +
> +	/* Requested period shorter than the shortest supported one */
> +	return period > wf->period_length_ns ? 1 : 0;
> +}
> +
> +static int adt7475_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					     struct pwm_device *pwm,
> +					     const void *_wfhw,
> +					     struct pwm_waveform *wf)
> +{
> +	const struct adt7475_pwm_wfhw *wfhw = _wfhw;
> +	u64 period;
> +
> +	if (!wfhw->enabled) {
> +		*wf = (struct pwm_waveform){ };
> +		return 0;
> +	}
> +
> +	period = adt7475_pwm_period(wfhw->freq_idx);
> +	wf->period_length_ns = period;
> +	wf->duty_length_ns = DIV_ROUND_UP_ULL((u64)wfhw->duty * period, 0xFF);
> +	wf->duty_offset_ns = 0;
> +
> +	return 0;
> +}
> +
> +/*
> + * A channel that is not in manual mode is not driven by the PWM framework
> + * and reads as disabled. A consumer's first enabled request then always
> + * differs from the read-back state, so the core does not skip it.
> + */
> +static int adt7475_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm, void *_wfhw)
> +{
> +	struct adt7475_data *data = pwmchip_get_drvdata(chip);
> +	struct i2c_client *client = data->client;
> +	struct adt7475_pwm_wfhw *wfhw = _wfhw;
> +	int config, duty, range;
> +
> +	mutex_lock(&data->lock);
> +	config = adt7475_read(PWM_CONFIG_REG(pwm->hwpwm));
> +	duty = adt7475_read(PWM_REG(pwm->hwpwm));
> +	range = adt7475_read(TEMP_TRANGE_REG(pwm->hwpwm));
> +	mutex_unlock(&data->lock);
> +
> +	if (config < 0)
> +		return config;
> +	if (duty < 0)
> +		return duty;
> +	if (range < 0)
> +		return range;
> +
> +	if (((config >> 5) & 7) != 7) {
> +		*wfhw = (struct adt7475_pwm_wfhw){ .enabled = false };
> +		return 0;
> +	}
> +
> +	wfhw->enabled = true;
> +	wfhw->duty = config & BIT(4) ? 0xFF - duty : duty;
> +	wfhw->freq_idx = clamp_val(range & 0xf, 0,
> +				   ARRAY_SIZE(pwmfreq_table) - 1);
> +
> +	return 0;
> +}
> +
> +/*
> + * Switch the channel to manual mode with normal polarity and write the duty
> + * cycle. A negative freq_idx keeps the current frequency. A negative duty
> + * means disabled: a channel in manual mode gets duty 0, a channel in another
> + * mode is left alone. Each cache is updated as soon as its register write
> + * succeeds. Call with data->lock held.
> + */
> +static int adt7475_pwm_write_hw(struct adt7475_data *data, int index,
> +				int duty, int freq_idx)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	u8 val;
> +
> +	ret = adt7475_read(PWM_CONFIG_REG(index));
> +	if (ret < 0)
> +		return ret;
> +	if (duty < 0) {
> +		if (((ret >> 5) & 7) != 7)
> +			return 0;
> +		duty = 0;
> +	}
> +	val = (ret & ~(0xE0 | BIT(4))) | (7 << 5);
> +	if (val != ret) {
> +		ret = i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
> +						val);
> +		if (ret)
> +			return ret;
> +	}
> +	data->pwm[CONTROL][index] = val;
> +	data->pwmctl[index] = 1;
> +
> +	ret = i2c_smbus_write_byte_data(client, PWM_REG(index), duty);
> +	if (ret)
> +		return ret;
> +	data->pwm[INPUT][index] = duty;
> +
> +	if (freq_idx < 0)
> +		return 0;
> +
> +	ret = adt7475_read(TEMP_TRANGE_REG(index));
> +	if (ret < 0)
> +		return ret;
> +	val = (ret & ~0xf) | freq_idx;
> +	if (val != ret) {
> +		ret = i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(index),
> +						val);
> +		if (ret)
> +			return ret;
> +	}
> +	data->range[index] = val;
> +
> +	return 0;
> +}
> +
> +static int adt7475_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	struct adt7475_data *data = pwmchip_get_drvdata(chip);
> +	const struct adt7475_pwm_wfhw *wfhw = _wfhw;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	if (wfhw->enabled)
> +		ret = adt7475_pwm_write_hw(data, pwm->hwpwm, wfhw->duty,
> +					   wfhw->freq_idx);
> +	else
> +		ret = adt7475_pwm_write_hw(data, pwm->hwpwm, -1, -1);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops adt7475_pwm_ops = {
> +	.request = adt7475_pwm_request,
> +	.free = adt7475_pwm_free,
> +	.sizeof_wfhw = sizeof(struct adt7475_pwm_wfhw),
> +	.round_waveform_tohw = adt7475_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw = adt7475_pwm_round_waveform_fromhw,
> +	.read_waveform = adt7475_pwm_read_waveform,
> +	.write_waveform = adt7475_pwm_write_waveform,
> +};
> +
> +static int adt7475_pwm_register(struct i2c_client *client)
> +{
> +	struct adt7475_data *data = i2c_get_clientdata(client);
> +	struct pwm_chip *chip;
> +
> +	chip = devm_pwmchip_alloc(&client->dev, ADT7475_PWM_COUNT, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops = &adt7475_pwm_ops;
> +	pwmchip_set_drvdata(chip, data);
> +
> +	return devm_pwmchip_add(&client->dev, chip);
> +}
> +
>   static int adt7475_probe(struct i2c_client *client)
>   {
>   	enum chips chip;
> @@ -1962,6 +2249,14 @@ static int adt7475_probe(struct i2c_client *client)
>   		return ret;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_PWM) &&
> +	    device_property_present(&client->dev, "#pwm-cells")) {
> +		ret = adt7475_pwm_register(client);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Failed to register PWM chip\n");
> +	}
> +
>   	dev_info(&client->dev, "%s device, revision %d\n",
>   		 names[chip], revision);
>   	if ((data->has_voltage & 0x11) || data->has_fan4 || data->has_pwm2)

