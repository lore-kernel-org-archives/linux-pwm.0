Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752198;
	b=3JNQta95yrZ9rDCsw638QtcvWS/LqAW2vNIaX6ENYyMzpkw0mnMRGxvDiU48r5901AdE
	 HYDYaZgERGR8IXvUvhA/0ExzBaF8DPRwX2v/GBR8RRbA2YTorzbBwnRQ8/8hihTgOS2T+
	 qROTbTHSz2XWH+Goqm622oKl6MXNzgrwOfEXMl3YnV00zmxA4oS9BfHpmJhjJrYUNX5gR
	 xC+Ed1teoEwviKF2P9aYWadoiTFrrOoflvBBn7XzlHk9GR5+S84iDDmX2iv6VpO0Wbn4B
	 uQ88zCZ533T0lA5xDb826eydXj/KQVNYFLIPJyF+3MkzXCLBFwtzE3tsThlG/7UbVeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752198;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GYlTKVMNt6BGcFlMeO/BV1sAsdx0ZWW7cLqsRE9HwwQ=;
	b=x/PSQG4i+Km957l0ZsG77vI6vekwBvCMlZco5IqVKsKF3Ljcuouw9elBxuXRSXVCjPHL
	 2067FLnfV3Hu854mBnKaYbnP+lJre7FIflAaswfJCXVRNDxHvBSFrCzC8+P9rM18/3Ihz
	 +hn7ay5BAWhWHJ3B1ggLSQGlKINn1gvyadfIZlcwLyDpuopXxYyDc7q90Ac4jnSE84Z0X
	 bh0lv4sW/2Lxk6RRypmGAYxpG8DOgO0fwDQmVj6J6NltnSGoQ9DEj++yQC/pXBxPqB8Fb
	 zm+DkFg1yIFFy6sm3zsuIDLCkO/0SWsLRlU9kDQp7SpWAzt++NK0wAlxqNlssqXbIBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dsg.is;
	spf=pass smtp.mailfrom=dsg.is;
	dkim=pass header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=e13TolbH;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E234606A327;
	Sun, 15 Nov 2026 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E234606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dsg.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsg.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dsg.is header.i=@dsg.is header.a=rsa-sha256 header.s=protonmail2 header.b=e13TolbH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dsg.is;
	s=protonmail2; t=1794752194; x=1795011394;
	bh=GYlTKVMNt6BGcFlMeO/BV1sAsdx0ZWW7cLqsRE9HwwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e13TolbHBeyVY5pkcUgy+JHDw65snYt3C7zAEPoYa9uJgZupUsUjnc7D3EJsPdMx9
	 WY7RvszSS6OssyXjLIl3XrVp+KqpVdvcZhpVfeVZi1s91zQxL+jOxWNKpWlQDKl2cM
	 cCVY4ly5Q4WEoUHQOJMUgaAbvnicktJ4Qd+HCfSozDthihiVBE+zxbAJx2tCsJsOJ5
	 awMVecHGB2u/FA95KrvJdiKil99I9qeTaVcr8eXxyWNmZsdsRS1T4DgaLzrj3cnDN/
	 R2tu7jl0OkyHZ+zzCuVk0ejh+Xi4zbpSzo4rBV9AFcrjAdZtVZSgbl9/LwTzb/Pyl7
	 RIAp29HHihSxw==
Date: Sun, 15 Nov 2026 14:16:30 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: =?utf-8?Q?Dav=C3=AD=C3=B0_Steinn_Geirsson?= <david@dsg.is>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (adt7475) Convert to hwmon_device_register_with_info()
Message-ID: <avm-tbgWgTJNFTBj@dsg.is>
In-Reply-To: <d28f392e-82ea-44d6-83e5-9593b341a722@roeck-us.net>
References: <20261114004110.328050-1-david@dsg.is> <20261114004110.328050-3-david@dsg.is> <d28f392e-82ea-44d6-83e5-9593b341a722@roeck-us.net>
Feedback-ID: 186389362:user:proton
X-Pm-Message-ID: 3bc10b9a433e40daf2a48c55b7baf60def69b5fc
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
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:07:53PM -0800, Guenter Roeck wrote:
> On 11/13/26 16:41, Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
> > Convert the driver from hwmon_device_register_with_groups() to
> > hwmon_device_register_with_info(). The standard voltage, temperature,
> > fan and PWM attributes move to hwmon_ops. The chip-specific attributes
> > stay driver-defined and are passed as extra groups: the automatic fan
> > control points, temperature smoothing, PWM stall disable,
> > pwm_use_point2_pwm_at_crit and the VID attributes.
> >
> > The driver keeps data->lock, although the hwmon core serialises the
> > hwmon_ops callbacks. The attributes in the extra groups run outside tha=
t
> > serialisation, and they share the register cache and its periodic updat=
e
> > with the hwmon_ops callbacks. They do not take hwmon_lock() instead, to
> > keep this conversion free of locking changes.
> >
>=20
> I disagree here. If you don't want to change the locks to use the hwmon
> subsystem lock in this patch, add another patch to change the code to
> use it. The subsystem lock was not introduced to be ignored.

Understood. I did notice one issue while planning that change. Patch 4
makes the chip a PWM provider, so its callbacks will also need the
lock. If the consumer is pwm-fan, then when userspace writes pwm-fan's
pwm attribute, the hwmon core holds pwm-fan's lock. pwm-fan then calls
into the PWM core, which calls into adt7475, which then needs to take
its own hwmon lock:

  hwmon_attr_store()              takes pwm-fan's hwmon lock
    pwm_fan_write()
      pwm_apply_might_sleep()
        adt7475_pwm_write_waveform()
          hwmon_lock()            takes adt7475's hwmon lock

As far as I can tell no driver does this today. adt7470 and
aspeed-g6-pwm-tach are the other PWM providers I found in drivers/hwmon,
and neither takes the subsystem lock in its PWM callbacks.

I haven't written any code for this yet, so this is based on my read
of the current code only. If correct, I think this would need a hwmon
core change to give each hwmon device its own lockdep class.

I'm not quite confident enough in my understanding of the core to
commit to implementing such a change. But I'd appreciate your thoughts
on this.

>=20
> Thanks,
> Guenter
>=20

Thanks again,
Dav=C3=AD=C3=B0

