Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750335;
	b=yhOajnTcLWePLXfBr8riXXgAybRwvMb+sDSuCy37Lz2vMUiCcCN+K10ioHB7Ij4Hk9IH
	 UvvGAdBdmGFeehs8VocDa+dCC64Z+4anxDZoKeaTTnl50bat+VnjL0QtX9c+ZSe+uOfkT
	 SZ5rsFNg++U4XZlhhD43dfFrXyK4pKnIfWr6MSZA9UI5HDQhev0Sdsr79erwoGxqRtR2a
	 46kal3d5hxB5W7IJAf3aiMBc+lIC60Qy25P3eS+2w65Mzn8mAZSYHDD4HfZKN5QOQieaG
	 8txDbjW+sY5M0Yj7bGrh0mokzlCAnepjoBT60YlUJswBpBr92Uw/inU3ltP0Oqz60SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xOkdMQgEfZtJLgU0fFwbDzze1EactQ9BVvcxXQMDTo4=;
	b=jw5EPZn+rRJI8E8zu1tfemFAEUfXV3JL6RHheZpkBtvNBWM+SfecpvdGMHljx9jCMrUZ
	 6GYOZK9VHjM4nnwAz5qQOCtXS84allGLIjorfo6G6HSviP3lg5GjaPhkVmf2oK9FQ4TZ2
	 6VhshYSg/TPyket/Pfjj30TDftMibVYOUy2Imm5GGnIUmWFDa6sVxkH6Kzz9mOb1Hjx2W
	 ufhjZ6ttYv1Nw16gL69l0WRaBZw3zqJyA1A7lq3cgQ1vJMZcWdMuIOneJkEELW2aya3sG
	 mnFf+pC+gldeZh7N5+qgYhZSab8ul21lgBesVLTxAxAtZUmxH+46IH2gLKC8dwKHkZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Gc7IXAzh;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F997606A324
	for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F997606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Gc7IXAzh
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso469985f8f.1
        for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792750333; x=1793355133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xOkdMQgEfZtJLgU0fFwbDzze1EactQ9BVvcxXQMDTo4=;
        b=Gc7IXAzh91GyjohKVdF/dqUtsNyzi4sPLVW0lyc/2BtjrHoPY3BuCMCWOvD34hkCWl
         n60yTN2FJ1EMUDw7QSmeCBFOup8RfB+2be2lMwAMAManQ52u9j99pHXzo4kgpPBnBCsX
         R1zSbxojmhxoHKQbVN8ZX2CXKxCfr8r6skio8EFwjBAEJKUQky8PsxBzUuOa+UzPv7pY
         l2JCR7NLb2MIX+xS3NCnLVaQeAqg/IVTg4lP7wN9HJPUwz8P8hiXa1PsouDTh7h3D45C
         g9F5/6+prgmRj5i4XwKhgJnS24ANiPI4v29jBHOj5si/fGZTUQPHHUPKm8L2RetuAaB/
         CePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750333; x=1793355133;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOkdMQgEfZtJLgU0fFwbDzze1EactQ9BVvcxXQMDTo4=;
        b=ua8mwEyIWARCMogm9DnXuwY+ImrmvEm4dHZV4VOxCitJ5zdUJ/tKERkwqicD4GJQpo
         PLRmVP2p5oq6XKup8stNAa4RPr3WvxwFZAcAFv0CHfUIg/16M+44cOg66LT349uMy9MC
         6oE9yBBi1U2e3Hfd8OwD272IJpZnzaXsv3Ude4npGcxirSob39myZqF08R7fE7dN+T47
         zSSDvz4HyJDVRRHQgerrIV7oFx+OIIKvPDNP4KrTjMtGSB0wgaPIRvGWAe/ZTFZBy8Cm
         q/EzvAI3L00kY0vhbBIB7iy6JsHJh8eQDr9aGeqHH5Qx8/LskSBuBfD/oSri6a/0navV
         jhsA==
X-Forwarded-Encrypted: i=1; AKwUvBz6a+XmzJbg32ZSG0wnAWEIpdDOavQNpP2IprOGmJ8XcJgFkqRvjJCcyE/IElsatnffuDEONwHz0ik=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBLLcKq/o7Nk24D2x2U/AUqB/65tq/Crljeg+rjizQlSmlAqTG
	bjLVcntLLQ03y/dlAk3L3wyeGriaxuVjdX8tILUAmS3dKvAVOOg/pg7Sts+x4zUXZAY=
X-Gm-Gg: AYBFou19WibeBgmwLfk3O+2GRoeb3OqQEZn5W/YOawUAIzBZQksJtBZvrKwo2cmFV99
	gXJZ41CbKbgcJxcV8WVNRxUgEgZEJ1bwMtt+dSUqobRsM8pN+DQWFEItt1/YXdMAVWpNkiKzDaU
	cxIashxBfvpK+OlQcGkylrRpFMo3R2PIf+POQIRHfM0w7SJYCskWeJYig/Tijt2K7SiyCUsA68k
	vM1IgZFaXOdwBtqn/uuidXy4DIaFSzEwLcbZ0knVB57MCDfgU8hXUtipToNk22YfoxBCBHN8OVy
	mYoFKYU2WKTsA6BABByMkVX6TD6qk3SFtRHRtdlzLOova9LeEQDo85Ob3vAIqimNjrdLj5nToaf
	ml7+MC5h7PM9gXRLCMTYfXCQ2L17TYKc9BhpHNMiWIIQWg9XPLeCMyNL6FKz37UH7ra7KfIqkTS
	VkyGLpYiE3IFOIqr/JymkjLbWLksWCK8gNjVBxG8AIl7BYTM3YJFX62b7/e9JZ4v97zflDx6NJB
	QzoRyhYMewzi49Wo4LAWRXY7Pd+z07GcEuJN/wVHwyee9/bDTcx2DQ=
X-Received: by 2002:a5d:6f18:0:b0:48e:f47:273c with SMTP id ffacd0b85a97d-48e3854f342mr2931502f8f.8.1792750331152;
        Fri, 23 Oct 2026 03:12:11 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3804ccb4sm4289462f8f.38.2026.10.23.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:12:10 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry Pi RP1
Date: Fri, 23 Oct 2026 12:15:53 +0200
Message-ID: <cover.1792748690.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds fan tachometer / RPM monitoring support for the
Raspberry Pi RP1 southbridge found on the Raspberry Pi 5.
Please note that the patchset in [1] is a prerequisite for this one.

On the Raspberry Pi RP1, the active cooling fan speed is controlled via
the RP1 PWM controller. In addition to generating PWM signals, the RP1
monitors fan tachometer pulses. The pulse measurement and RPM calculation
are performed autonomously by the RP1's onboard Cortex-M microcontroller
core, which periodically writes the computed RPM value directly into
dedicated MMIO registers located within the RP1 PWM hardware block.

During earlier discussions, Uwe Kleine-König explicitly indicated a
preference to keep the core PWM controller driver (drivers/pwm/pwm-rp1.c)
focused strictly on PWM duties, rather than bloating it by registering an
hwmon device directly from within the PWM driver (see [2]).

Because the Linux PWM subsystem currently lacks a generic framework or
consumer API for reporting hardware-calculated tachometer readings, this
series implements a standalone hwmon driver (rp1-fan) using the following
structure:

-  The PWM driver exposes and exports rp1_pwm_read_tachometer() within a
   dedicated symbol namespace ('RP1_PWM') to read the RPM value from
   the MMIO block.
-  A companion DT binding (raspberrypi,rp1-fan.yaml) introduces a vendor
   property, 'raspberrypi,pwm-tachometer', to link the fan node to the
   PWM controller node without overloading or abusing the standard 'pwms'
   property.
-  The rp1-fan hwmon driver parses this phandle, establishes a device link
   for proper runtime and unbind dependency management, and registers the
   standard hwmon 'fan1_input' sysfs attribute.

An alternative architectural approach to the DT phandle + exported helper
method would be to model the tachometer as a child device using the
auxiliary bus framework (drivers/base/auxiliary.c). In that model, the RP1
PWM driver would instantiate an auxiliary device for the tachometer, and
the hwmon driver would bind to that auxiliary bus device without requiring
a separate DT node.

However, adopting the auxiliary bus would require a more significant
rework and refactoring of the existing RP1 PWM driver. 

I'd appreciate any feedback on whether the current companion driver with
a dedicated DT property is acceptable, or if an auxiliary bus-based
refactoring of the PWM driver is the preferred upstream path.

Patch Breakdown
---------------
Patch 1: pwm: rp1: Export helper to read fan tachometer RPM
Patch 2: dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
Patch 3: hwmon: Add driver for Raspberry Pi RP1 fan tachometer
Patch 4: arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node

Thanks,
Andrea


LINKS:
[1] - https://lore.kernel.org/all/cover.1790686331.git.andrea.porta@suse.com/
[2] - https://lore.kernel.org/all/adLTwOTbkJ0VQXy6@monoceros/

Andrea della Porta (4):
  pwm: rp1: Export helper to read fan tachometer RPM
  dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
  hwmon: Add driver for Raspberry Pi RP1 fan tachometer
  arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node

 .../bindings/hwmon/raspberrypi,rp1-fan.yaml   |  39 +++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/rp1-fan.rst               |  41 ++++++
 MAINTAINERS                                   |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   5 +
 drivers/hwmon/Kconfig                         |  11 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/rp1-hwmon.c                     | 136 ++++++++++++++++++
 drivers/pwm/pwm-rp1.c                         |  27 ++++
 include/soc/bcm2835/raspberrypi-pwm-rp1.h     |  10 ++
 10 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml
 create mode 100644 Documentation/hwmon/rp1-fan.rst
 create mode 100644 drivers/hwmon/rp1-hwmon.c
 create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h

-- 
2.35.3

