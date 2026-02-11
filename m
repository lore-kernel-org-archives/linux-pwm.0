Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7A35505A
	for <linux-pwm@vger.kernel.org>; Wed, 11 Feb 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802150; cv=pass; b=umH6UE8SqhqCoaSDrswGI/9sN2GSSlMcsL1LJhXSfZh6SvFp0h2+0dCvdDx5akA0Qt0KXa+mOxWY2oQIOetNeqK62E8mlI4aXt8yMhOrvBNgZ3baGrujyOHsYe6UYut4sLfIuBxEuKBJ8oziUmCW5Fo41KbUqIxQSk7hWCEmBGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802150; c=relaxed/simple;
	bh=st7mBB5P+w+XMEMxHebgxziAw2hDjCjrDF/7PALOjBg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oFduPu5yJMNpogz6n0aDD9rU397BIgZ+SQy5ATsWDDYApokexuy7DGlCaQaLmPoe7bP+F9xyyL62i/6gtL8/GZ1/l2PzTIcs+u3KmV7QGkaBQYejACTQdG4gqJg9CS3UMje9Ci1oUW0KktNLXb6Hbez6c7Ng1cs04loojfSKhAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV4prTCP; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV4prTCP"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so849487b3a.3
        for <linux-pwm@vger.kernel.org>; Wed, 11 Feb 2026 01:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770802148; cv=none;
        d=google.com; s=arc-20240605;
        b=eISLWBPri+aoOFxCGWfrm3ZhQ0J/mXcCBzFY2z7iU3lbQYJQxHx7DSUCq9Mt9JzhwA
         RNkGxNUYxSzdiFzUh2Iw4zbmknsEMeflkkIYcO4oR54WR7jNJpcqfgRMd7261gLmntOP
         9ZNaNZtyrXmIwGo+34xUTVr+bwxciedw+NvhraILve0OvwmJaILHg0ekjRG4LCyY9F9k
         CiZ6AdXAqwhZbJyzQwFQkCQXsgG1qt6nUwlVVf7jB1InuSxOhv65Ir9FkyTpMu/PbXPX
         zTIQh2wtypPX+dB3bi3BZhxK9xWIsN5DJHqA8iqxApjdeARDY6E35lEk1raJoRu7ePid
         8RRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aUbA9gGxOOEYzhQsTmOgo18IUBnbAndmse6CKYRwrX4=;
        fh=MACSAEZUhVEqIDa6frB//8klP9Pjj8wUzusa22mwpEk=;
        b=Kd8V9DvmoJgArl1LCe43ebbjHsx2x22dKWq7/5Jeh22efYtpwffUSrj1JFAAk27cyW
         tDMLQmb9n5vstpzFPilFRoiFTfV7RG5asGQB6OLmuMIaflJfPiBiP/oCXQS8uI067QE4
         eaxp4aLvRPceXB3Npy7L26/W9lEFuX6X1s4fb0i0WqlCwf6ZDfTtjAKM6XlzxUc6mbQv
         RihdBNMaXfKG0k4wCHdoxGAEuGV/R7FvRkyGpG9oEx6bD630AfwDpD9U7nOfuvCmcBcW
         FcrEdruUalPM5EXF3mZqJlQp+B4Fy+uDriUZPItHp0SY1X+dsVF6h5LGfz+kI5SGKIWW
         TYmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770802148; x=1771406948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aUbA9gGxOOEYzhQsTmOgo18IUBnbAndmse6CKYRwrX4=;
        b=gV4prTCPGcaW7kHfvuw7dDZDeFham3IDmLo/TMBg1YWwKvU4bruk7+3B6X2wZTE6Ka
         li08cX4GV/dWkSqwfuAHtH4Rp2bPR4WWx9hvn2n0F+teZq1O0bH1hZH2zkYeE1NGaLyo
         RFjLwm2y+fXWushdHwbIEQqsYUzCahvrg4POOwnNVfs42PX0y5Ky9o81baJYnkFNKb/7
         7d8k3cE2tW0H2NFVxLL5lj0juFlLnk/5+n5O0z+MxMBOHCwHn/Qc1NYWUhTVbZCyYoZH
         clsdzwQlMnFgOYA8y6ZLMggLLN89nUBoJoLPdxSlciyJ9VyGL9Os+gwORmRARCWLWfqh
         InhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802148; x=1771406948;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUbA9gGxOOEYzhQsTmOgo18IUBnbAndmse6CKYRwrX4=;
        b=N/nNdU0dOEo5hgecuF5Gc0f7mhxOPY3+VxLkvAQGOobfueGfx9oti7TBcQ3MOT4buL
         JoXgFtlRNhZWDZoHFVRyRLjQy9D/TJOraE/q0W5Zrx0CqOOpVXiRdToUPxz+XZwReo6b
         fiHcqBi9+F/2L1wzuV72CzIbDfczDGDbf0SwWrERzOqn2/Bdl0XGcC6UlwGiQSXRiEAc
         CwRKhk1PHzNf/AWzY5u7m6ek/cS3qjS6iJ9zCP8ENHV46SVHjZotMx/VfhaBF7ON1Ata
         rpUyLTSzZ3zAssg8j+Q73h1E+HeYAoxDA5MyXSBlkrAB8ERef9hSfwitgIXxk0N385WI
         RjbA==
X-Forwarded-Encrypted: i=1; AJvYcCWxruWfrVzpfqAfKb5G5c5pvngL0EQW6Fwwxtka2rHoJJHTBD/tOFJ+gee/3/bBlLB0bW2LOwi9+gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aNZvaBMn/uGvQTnF0UN4wWcfAsfPMyKEnZzj75P0qPdE30pE
	9M6H5JN+fXnC3Wc8EMPdSEeABJOMPf9dMGCedna7FzxIDHNc13X35u0BbottiT5bY5tPQt9Z3Gj
	RyB682zNW8HacSXsyzG6lEA77aHPO/QY=
X-Gm-Gg: AZuq6aKQuM6MoKGQtk5bqpUug57UyETmdd3Acwhzfv9XOmPNDqutO6ZV6Qj/LFjJ+EY
	j7gbqJ8ASrHIh3GYgVXW8WDN/9MkVD2Zi8FwrUuu8FrpxZKRkNaH2+OvlLvMl4MQeHHRfA28+Ml
	yBNdS2chtIaGc5ubzDP0DfnhPV/1lpF1qX31IpD+u2aqGtMr+EWEIx5qFIl/l6Ac9xr4RBdI0Gn
	NaVOc6sCci8M4H7+Fuo9/feRfEtAmIbZnUMFc8TZapBCzZeOfx+RFM4ux4kPylLFP2YWSNtiPdn
	zZwC/g==
X-Received: by 2002:a05:6a21:6016:b0:366:14af:9bd8 with SMTP id
 adf61e73a8af0-393ad3ec860mr18302078637.78.1770802148294; Wed, 11 Feb 2026
 01:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 11 Feb 2026 10:28:55 +0100
X-Gm-Features: AZwV_QiVqa8nk_229fGgFvAqqTvdw2d0iztKljKI9n_cT6yo2PG5Hw6XUKahYLw
Message-ID: <CAFLxGvyhdpQMnW6VqyXjLPKyZSQvrV-+GFdUogV4JX7DiGePyg@mail.gmail.com>
Subject: PWM implementation in HWMON and backlight
To: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, 
	DRI mailing list <dri-devel@lists.freedesktop.org>
Cc: ukleinek@kernel.org, lee@kernel.org, danielt@kernel.org, 
	jingoohan1@gmail.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"

Hello,

The backlight of a board I am working with is controlled via PWM.
Naturally, I thought this would be a straightforward task using the
pwm-backlight driver.

However, the PWM in question is implemented using an NCT6106D chip.
The associated HWMON driver, nct6775-core.c, does not implement a
standard PWM device interface but rather its own custom one.

I am a bit puzzled, is there a specific reason why HWMON does not
utilize the standard PWM framework in this case?
Also, in case I have overlooked something: do we have a backlight
driver available that can interface with an HWMON-based PWM?

-- 
Thanks,
//richard
