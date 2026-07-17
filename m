Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA91E98EF
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248408; cv=none; b=GDIcQKuli0xGlxvGp0yP/F6zqWht7S2VApzbFuASWw5/hUphYBvjR4oFqnEzoQfo9iBRpwzLkkgw1NR4UX16SGB5g/nM9LNAdV2rlPHhTcZDamQ+nCjbsrFGAqypQEibUpnUTBCcowqB4xajmbiQettuVILxDEJbIz7e3/Jn+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248408; c=relaxed/simple;
	bh=LUeZ7PoROwJXdCUV2ckt7VTKtyjdbcIz+8qX4WtsqLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjuVNR5y81GcKaY+ZO04t1b79HHBG8WlW5vDsGaRIdOImSA8NQOK0TxA4g6Coiz5EMsb9bT/TXuufqiIsCtSrHgZwDivxhkJd4DWKBY7dAR1sKpDD9xvWA89SowoDbc2yCCizkGaw8mVmROpq7FB5ioOpbs3eDClQdeKSyIOocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USeF9gf2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USeF9gf2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso87854595ad.0
        for <linux-pwm@vger.kernel.org>; Thu, 16 Jul 2026 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784248406; x=1784853206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uPNpnjtf15pOqkeyn/OTIVkD0Q5Q/QxgSoCVuNMeg0=;
        b=USeF9gf2qVZKlAk03bVlbxi0v2wbQy7kXyVTB/Z8EkOv6JXD8zkGGJQFw7ZezBm954
         ebmZ95iIBVn++MBKrXUhJfx47LyqHgtzSsQ0GK8SkYlDPxvyek9Nrqy4JBOxLtxrppI/
         Wc4lXzRTfcDBYGKeL+wNtWnxybI7Xq/u7mGH2y4eYNQEVDx4+NMWpX5bgpYv272TBgrG
         UjzRC2s/2PrA2X44XYEPKHS8b0G7pp+IzMVzEkRUQp4WJ+mtwIPvs/Pu+qlMPToPxM+G
         YLuPESdBgmKYXNQlm893ZYEAV4E+1sRCHh7iduA3wntNLcmfJ/ME1ImpNpTeJKi87n0Y
         65+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784248406; x=1784853206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1uPNpnjtf15pOqkeyn/OTIVkD0Q5Q/QxgSoCVuNMeg0=;
        b=iGDjigL/kBBGPto3UXn/0F4JcKHKcE0OJ+NKxnY06BRpXFt4nwibXX6CiU/CKM6aRS
         +iJxHYlSdZvonoNXWOrJU0uQ4VjxF2rU+CHAK6AFo/4NSbgqOBAxZ0JElQd1vxuf5kJ6
         HCvVY+q3etViF+GsMmsXDBDake9cma83lrWXOrQcWzOuCBkBdc9WpLu4tsqDDXh7RXJ0
         JPxkmlkDevSUUhm8euIiHEZMyN5AZd1zw79F2N92Ea9OkQ1OJ3LT8K4CCyTvb1QZVUBw
         hI3KE7W6Znw1s2Qp2s1eMtvXPJ/REHriUCORxfFvYyA87fhBrwynVQ6SsdTORpoh/WBe
         nTCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+5eKGq8x/nTEp00t7TUzPDVYnI0xVy6hLuSrd/bdqTiayrrvsVmlDZoL6yQPxaLDk9XXc8aNtQjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5v4yVgGcEn5OeCrO12jaop4dUymgTTsfW4VE4X7ReJp1PsmsT
	ZN+NU6nCtZOd9SeNWtze04qdQsYm3vSvFzWo57qJSDDLeNb2a3nbGmKm
X-Gm-Gg: AfdE7cmsyEQ7PpKis4LefaaVA83P7osxxv9jIbF+RhOG0DG0ot2GYp6TVJQ8G2NUOYB
	tIzoit+O5anXN/1Z8JxMHh2VBPaKB7eRb3Aq0PcrvnYx+08VTxeXDFPxfQgGqG0wK+dqezVR+N0
	9V/KAAODYYAt6pNFmMQVl1Cm6Mk5eTKZZ5gPl/tTg6TtGdjYsjU2mZT9Ly7esPOn0W6Q/PFe3Oo
	ehKxWyvWrgUYZ4VDQN2M8MybO9yitAAWXVCyVy4HLCkyoltmYjOG6Cy9QBktXI3jNMDNFTXr5di
	mELjn3RZ8jJza5u/ym1Wps8jkW8KRros4GrQmVvH+T7PbTchbTiaMwf9DkKGxBchOCD12YIGcGc
	R/nUl0M/Tj7aCMhM34YXuVmLCh7ud3+gyyIN1wYKNOS/4bUE6B2Evqq7aFR5JzT97UfBgECo2ue
	hky3c2PRM5heJsUtw7TsuARwk4YElS6NR44RRu44NY53HyYG4Cdqvf6A==
X-Received: by 2002:a17:903:3807:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2cf349175f9mr3229355ad.21.1784248406238;
        Thu, 16 Jul 2026 17:33:26 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f4481sm1139735ad.32.2026.07.16.17.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 17:33:25 -0700 (PDT)
Message-ID: <c95a8d31-f84a-471c-b216-f4cac5faf464@gmail.com>
Date: Fri, 17 Jul 2026 08:33:22 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com, Trevor Gamblin <tgamblin@baylibre.com>
References: <20260617025925.2539334-1-cwweng.linux@gmail.com>
 <20260617025925.2539334-3-cwweng.linux@gmail.com>
 <alj1UapHAq9f_MiF@monoceros>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <alj1UapHAq9f_MiF@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Uwe Kleine-König 於 2026/7/16 下午 11:29 寫道:
> Hello,
>
> On Wed, Jun 17, 2026 at 10:59:25AM +0800, Chi-Wen Weng wrote:
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/math64.h>
>> +#include <linux/mod_devicetable.h>
> Please don't include that file, <linux/platform_device.h> should pull in
> the things you need from that file.
>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +
>> +#define MA35D1_REG_PWM_CTL0			0x00
>> +#define MA35D1_REG_PWM_CTL1			0x04
>> +#define MA35D1_REG_PWM_CNTEN			0x20
>> +#define MA35D1_REG_PWM_PERIOD(ch)		(0x30 + 4 * (ch))
>> +#define MA35D1_REG_PWM_CMPDAT(ch)		(0x50 + 4 * (ch))
>> +#define MA35D1_REG_PWM_WGCTL0			0xb0
>> +#define MA35D1_REG_PWM_WGCTL1			0xb4
>> +#define MA35D1_REG_PWM_POLCTL			0xd4
>> +#define MA35D1_REG_PWM_POEN			0xd8
>> +
>> +#define MA35D1_PWM_CTL1_CNTMODE_MASK(ch)	BIT(16 + (ch))
>> +#define MA35D1_PWM_CTL1_OUTMODE_MASK(ch)	BIT(24 + ((ch) / 2))
>> +
>> +#define MA35D1_PWM_WGCTL_ACTION_MASK		0x3
>> +#define MA35D1_PWM_WGCTL_ACTION_LOW		1
>> +#define MA35D1_PWM_WGCTL_ACTION_HIGH		2
> If you make this:
>
> 	#define MA35D1_PWM_WGCTL_ACTION(ch)		GENMASK(2 * (ch) + 2, 2 * (ch))
> 	#define MA35D1_PWM_WGCTL_ACTION_LOW		1
> 	#define MA35D1_PWM_WGCTL_ACTION_HIGH		2
>
> you can drop the static inlines below.
>
>> +
>> +#define MA35D1_PWM_WGCTL_ZERO_HIGH(ch)		\
>> +	(MA35D1_PWM_WGCTL_ACTION_HIGH << (2 * (ch)))
>> +#define MA35D1_PWM_WGCTL_CMP_UP_LOW(ch)		\
>> +	(MA35D1_PWM_WGCTL_ACTION_LOW << (2 * (ch)))
>> +
>> +#define MA35D1_PWM_CNTEN_EN(ch)			BIT(ch)
>> +#define MA35D1_PWM_POEN_EN(ch)			BIT(ch)
>> +#define MA35D1_PWM_POLCTL_INV(ch)		BIT(ch)
>> +
>> +#define MA35D1_PWM_MAX_CMPDAT			0xffff
>> +#define MA35D1_PWM_MAX_PERIOD			0xfffe
>> +#define MA35D1_PWM_MAX_PERIOD_CYCLES		(MA35D1_PWM_MAX_PERIOD + 1)
> This is irritating with similar names and different values/semantic.
>
>> +#define MA35D1_PWM_NUM_CHANNELS			6
>> +
>> [...]
>> +static int nuvoton_pwm_probe(struct platform_device *pdev)
>> +{
>> [...]
>> +	nuvoton_pwm_init(nvtpwm);
> This clobbers what the hardware is doing. The idea here is to not modify
> the hardware settings at probe time to keep e.g. a backlight configured
> as it was setup by the bootloader and only modify on explicit calls to
> .apply().
>
>> +
>> +	chip->ops = &nuvoton_pwm_ops;
>> +	chip->atomic = true;
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Unable to add PWM chip\n");
>> +
>> +	return 0;
>> +}
> Best regards
> Uwe

Hi Uwe,

Thanks for the review.

On the include, I will drop <linux/mod_devicetable.h> as
<linux/platform_device.h> already provides what is needed here.

For the WGCTL helpers, I will rework this to avoid the extra static inline
helpers and compute the 2-bit action field mask/value locally when 
configuring
a channel. The WGCTL action field is 2 bits wide, so I will use the bit 
range
[2 * ch + 1 : 2 * ch] for the mask.

I will also rename the maximum value definitions to make the semantics 
clearer.
The intent is to keep PERIOD below the 16-bit register field maximum so that
CMPDAT can be programmed greater than PERIOD to generate a 100% duty cycle.

Most importantly, you are right about the probe-time initialization. The 
driver
should not reconfigure CTL1/WGCTL for all channels during probe, as that can
disturb a PWM output already configured and enabled by firmware, such as a
backlight.

In the next version I will remove the controller initialization from 
probe().
Instead, the driver will configure only the channel being changed from the
.apply() callback. The disable path will only clear POENn and CNTENn and 
will
not touch the waveform/control configuration.

Best regards,
Chi-Wen
