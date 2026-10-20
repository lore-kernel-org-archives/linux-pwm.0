Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500203;
	b=Jr8cHXDtKdNPSYQp1vWRtguPrP4EecEpaudaQguWb43qfJ//2JpIFbbU8iIqVdUCS4Cf
	 xZ4uEcL+IG+Vru8Cq9nAcyNvIaCIOg8+iMLysQV6uzIRYsKpAkqzN2k8z2Gv8M3L8od7r
	 LP16jbWfmL7rjni4CKyi93BPAuL11/HAO8US+sXuDfikthv0H/zYLteLC9oT6Rhf1/9+e
	 R+VIZisCVBlEEikcKL7j2B53cdM0oe4Fyn6m6tplWWQl1s9CeZ9AMXe2Q0Vs0cdfyPyFv
	 YoJnrDR+6uHZakfVNEMfFCRfpycMFG9+NQF4WYu58aiEGiuurgvQcWoelO2Ws1X8+Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
	b=qSzVICdUhUOCir4RDW4HUL65We18XcREI+GS1uO4vYI85SjUH9mzYyw+/TX2/GJ2EjrQ
	 FLJ1ha2WgxEhN5FTmzcCofpWqzyMGP7TjrTDbHIJNKGYRCHJQsH+LQDJNtv440uJYhw4X
	 PwoDJ1+nT8Sb28ut1PiAd2E9hIZnp2D7JXJlSdo8nxAP4hjgC8Kab5hCMjfWksYLFS6Es
	 7BQkIoUhEMvyKh5aYtlw8mWE4XI5wwUHrs4sTS6+4SDkZDwQExrYrkeM3NjVP/MiFVEmu
	 KR2WB40mc1cGR5/OZxeqPY8Z635alZ1cN1pUOl1G9gwNxUdTf30/swOSBkor+vuqTrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBE7MP4L;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813F606A325
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 12:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7813F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBE7MP4L
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35b2c599f43so587432eec.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500202; x=1793105002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
        b=iBE7MP4LiiXqwWMF8SJq2RfYIZ2T7MJv8zOoaiOFkLAV1WuVTpqMVKlupysFYR9agD
         JoIUmQsM2Wd+Jr1zPqhHEqXgvd8LIP0lBJOxxr0v3fo3flQ7529Ib/Xi4OR89hlo8lqf
         Dxd3GUFj1P5Ej+lsMC82WQKoc+HsZxvIpghogS7SsPkwm06fuPr5T8/Gm/N7/u4H8qCu
         qahCwD73SDmXZB+GPZ2IKk2ROTHCQL0k+Pyw+T3Mwnb3VB1aVYDmNAH1yAE2PBU7au5L
         ywiezeq5X35K+GTEhYn4Q+rUR8qPttM0Gogem86PxNmwgMQksM51g2JBijd5II/rMhB0
         edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500202; x=1793105002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
        b=UyqFxZNZ+7GktKm4Z+XeUfh3gSRM89zIIlBHOs2iGbCLwD4d4u74IqoVa2v4GUL0Pa
         K4Pv87Mipv+mmgeR2XYYff0srxspMa2en2xu90y5RWwXhluBmLG4JcB/tk1ZfB2PRV/p
         hH8K/MC4ZhFyOv+n2+XPWPo30vvOnPFiAIFa9QbupDABD5kT/CahA/izNh+Diz/LLDL6
         RFy25pHvqHjheJADnqcrWsEoaF5HryCOOSB+1E+kiapRqcH0pWFfpnEiVUF/gIScN0y9
         CzsEhoA8mmrwU5Q9DxwHhRktVMHbGjNIN1gAX8ObIp4Z17lUOX4x5qobjnOcVcrNxNOl
         5J6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwVlk+jpgp/KyL2mEJWo8B1Klb9OgDt13eUvCQ6HJQ/xKB4XWOmbzmi5nnMw5QxC0bar/zYJYvRxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoYbiUQ/K8KzvVugypMDaCS0O+P/Mo916qExTgeD6hm2jb3AHK
	g3uJ9Vx9C+qt6BahLINQrsDvVgAqJA6qfZph317Ty/NaHRgg2pzvd9LQ
X-Gm-Gg: AYBFou33kHXcIh3c+miEX3PKPICLThsNWxEY0mrtj3YoO+AW5yTA7A/uoPg3q+MOL8G
	jtD3km+t8wTZjwLANPhdmr4QY5DIhvqN3SCdL27hBgot2zk5yB0gLhKThUQ/IkzfjZNAntFqhdF
	l1tNMTyz1XAnEHl/41NkB7DDdB45ps++g2ncXTe2Isb87mM9Ah5GNAYSafBvEQNSaz3/ZB4p63f
	zav5NaO9eR/KmOVEGDgDzvAeqJcxwpUZXlozA//CknqNWx7gQlKMouJHCI1AWUFSAf1o6HvrQ+b
	4UmFTX9eOxM/r5qZjZrla2wd/ZB4ELMSRkHGYqKQRpo2MNOGJDuYhwj382NiKOi/1gtREXqV2Ft
	R0hy0rs2YhwTvbenkej1Asehcmm6g3W4y4nDOyNx1r1RGiz8XQqb4UKQzMNh7Rvy84KK8icxvvT
	Di7fDmkZUau7d8adsIojBdjVJb3pp+Oan0K5gsVLv4IJcOH2YpU8UKHM0UtfE/w29CdY6rzfVW0
	XMZInj8XO/uuZxzqEHQQJPbDdrFnX5PjHkFVZivO2uy7GyXajmaJ260/lZs7GgL3eaS2LyUHEgG
	hQD+
X-Received: by 2002:a05:7300:de49:b0:35a:7020:c08a with SMTP id 5a478bee46e88-361a186094cmr14849051eec.19.1792500202072;
        Tue, 20 Oct 2026 05:43:22 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm40204577eec.18.2026.10.20.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:43:21 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 20 Oct 2026 09:43:07 -0300
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <v5meo6y3jn6vcmv7kqtbqqv3bq36xb6pk2kysdwpwkfvixtqzl@rojpaxrte4sw>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>
 <atdcOsaDbtaQJd-9@monoceros>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atdcOsaDbtaQJd-9@monoceros>

On 20/10/26 14:23, Uwe Kleine-König wrote:
> On Thu, Oct 15, 2026 at 01:49:47PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > +static int ad9910_drctl_sync(struct ad9910_state *st)
> > +{
> > +	struct pwm_state state;
> > +	bool ndh, ndl;
> > +	int ret;
> > +
> > +	if (!st->drctl_pwm)
> > +		return 0;
> > +
> > +	ndh = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_HIGH_MSK,
> > +			st->reg[AD9910_REG_CFR2].val32);
> > +	ndl = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_LOW_MSK,
> > +			st->reg[AD9910_REG_CFR2].val32);
> > +
> > +	pwm_init_state(st->drctl_pwm, &state);
> > +
> > +	if (!ndh && ndl) {
> > +		state.duty_cycle = st->ramp_down_time_ns / 2;
> > +		state.period = st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_INVERSED;
> > +	} else if (ndh && !ndl) {
> > +		state.duty_cycle = st->ramp_up_time_ns / 2;
> > +		state.period = st->ramp_up_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	} else if (!ndh && !ndl) {
> > +		state.duty_cycle = st->ramp_up_time_ns;
> > +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	} else {
> > +		state.duty_cycle = 0;
> > +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	}
> > +
> > +	if (!state.period) {
> > +		pwm_disable(st->drctl_pwm);
> > +		return 0;
> > +	}
> > +
> > +	state.enabled = true;
> > +	ret = pwm_apply_might_sleep(st->drctl_pwm, &state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pwm_get_state_hw(st->drctl_pwm, &state);
> > +	if (ret)
> > +		return ret;
> 
> Does enabling the PWM have any side effects? Are you doing that only to
> be able to call pwm_get_state_hw() and thus find out what the resulting
> output looks like? In that case, pwm_round_waveform_might_sleep() might
> be your friend.

Thanks for pointing this out, will look into that.

> 
> > +
> > +	if (!ndh && ndl) {
> > +		st->ramp_down_time_ns = state.period;
> > +	} else if (ndh && !ndl) {
> > +		st->ramp_up_time_ns = state.period;
> > +	} else if (!ndh && !ndl) {
> > +		st->ramp_up_time_ns = state.duty_cycle;
> > +		st->ramp_down_time_ns = state.period - st->ramp_up_time_ns;
> > +	}
> 
> So the configuration depends on the previous state of the
> AD9910_REG_CFR2 register? That's a recipe for surprises?!

Expect not surprises. It depends on the current state of the
no-dwell modes, which defines bidirectional, ramp-up or
ramp-down behavior.

That is documented in a later patch. ad9910_drctl_sync() is
called when dwell_en or integration_time attributes are changed.

-- 
Kind regards,

Rodrigo Alencar
