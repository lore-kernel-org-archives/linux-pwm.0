Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541583;
	b=aywwZCo8MNpeQzTLfxEalUWkqcH0+4zV6FVSprsoZjUwr9RiLtrr6kyxCV9hbEj8Rkfv
	 9TTVFnGfoIubEw399V+4lhqAdy10yI+kkNDS6eWDWVhJTDjul67USBJ/795OX8shLZWhs
	 fZB+xIqIUVJIXBqwLgy0MWxvZDpfzIQHVYPjBBw8zQATX0UU63UvOX7t0xaENpNnOX2Py
	 GMK7aC/41SICcFGSwVy39tC+mv6HiAUsjP+nDf1n4H6OehKnw5YUOMTNHhq0W0mFqHLrY
	 MVeg7J0z5Ub+8TtpfPU3o8OmuBYDDHF1EWsoFkwj5ZVte30L9e5bz3d01jwyftJkUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SGN0CE6hboOJyWQIpluS979Wc6QFsvjzK1IJ9fJlXFk=;
	b=RJQ9e4w12FjTta84GIWVNgKlHgD1bVTFrPTBglRNhN9gGenAJvu7oJK2kGM2zSA1oF32
	 JQGtPvNeoCET09Qgy9GpaKwcFv5Zb2VN8ipgxk+3f9hejuq6sTVJx4zLsdEk83UEWKHmM
	 LFEKGc7XyZKCp7QIyQjoYGYiQx68KcMmGWhfEbQV8cFobJlbrQSSD4dokZqqwAAYJQlHv
	 0/EIkfeBsaHa7oUq8lE1Jcytwx4u3sk6eaef7/rh0FB9D1pncYbgjE2R9PxLilK6dcPcQ
	 mIqKR358S33URJwiSGIuTh81AHs/AGBSGZZWS/alVJPM2TNEtVMbLUuOJEaLsb7oFkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RXwJn5AG;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889560A2605
	for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 17:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C889560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=RXwJn5AG
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a9be758734so3024264f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795541581; x=1796146381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGN0CE6hboOJyWQIpluS979Wc6QFsvjzK1IJ9fJlXFk=;
        b=RXwJn5AGyO6dganRr8aighjFMZJNJh4XjfhOO2zFgOYt7YFmihqlkoSNP/Sd2qk7mR
         FfbpIqRpuaBVKaT+fMr4hUegmk8cVx6CP0R2/cm5K41diZ5crRoq0LTYsfsSc0xlGEis
         4wTTWUI8MViemNC3LrHUXWWpCCIvfPI8YHfyVz7VNAJKkQIJeYbgJKBnhRpzIckcSeSl
         /l/kI7mn0mx36m4fmMzXi9hpGqVByRsyhWGpUAtHxlchwVQGBJ73cKW/3E0pMSVOeJO+
         6oSjyXnQidug3UWD3+bGNMTRkr5z1+35e6FlZZ9XnGhhqoRHAfbz48Q6kOUeMZGbDIzP
         ARIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541581; x=1796146381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGN0CE6hboOJyWQIpluS979Wc6QFsvjzK1IJ9fJlXFk=;
        b=KrQHD3r7pYZQaAGqehFMya8LioEQsPvB3gPlpvOBATNWzilFDA4yaXdyp5RIuK5GrG
         SQhjkIOcfzSCSAnJ1dvuTopyoHn0coc/babAeLrhspx+QwuItmuwXGvdjCvkGsG62B1t
         hkUBENZ0j/HWPANs6Dw+WZrnyKpHJxh44wRvfsCv2Nx75S0Qd9nx3u3TDMwUCsKIYTad
         kg6HPKWvqkOQERAm7IKaiT08Oby+Bmw32k2FOfTChn83H9h34/7ASaUZOMcVYAlkwsGf
         MBO6cdBIFyVJGzkUNK4+O7Qcx8WOVnZFMu3Yw9MbU1hSCqO6ERPA7qJWfq+KfyJ7qUNK
         Mc9w==
X-Forwarded-Encrypted: i=1; AL+hErFXXFN0nNCxbZH/KazN58/kQzPWrV9wFDFMZ++R7DAEOwwjv0bqp/ZukuVW7tMopqE5z4S7YhGqGz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BSsok9rUhugS9InGRoyG5c8BtplapRYOUp1kjRcmV2rnArZI/
	P4Y9RNjpm4rmSK4sNKVRvJ6OYsUDdrKVs4ImwbYZJfGO/Uy+WwsZuSwq0L7SxqrOLPI=
X-Gm-Gg: AZFdTZeSDjmNOUrNp2EpyfhD0s86sd6wxKY7Dkg5IpfOSfOXESVR0YOxuHzMycKXDzl
	2IEnQtVNSsz7XD9ZCPIVu/MQVBOl1oJDfMGzKVFo9gRRWukQCbjAIkPgFPZifb+bVtf+DA4yRRo
	IXUdaFegYP4w8J1/ZAEqb899mKN/u1q0YHWVcf6vNGimxxRMEJqJmj4v632JEJH/220pOIA2+6U
	qVWjF/upkRZq6mdg8eT621lz0bjcKSZX2btwi3IupMADpM7vcW/kB9lQy6kxwblDFXIbITO2bpr
	JoRlfBlir2g7cEczQhyD5UD6tQhO5WNeQMQ9M5fZAmqTK/e5XwxhB00ZwYFM+ha43EgBbk/gbha
	8MCST9MI2P56k55RX1nkXXJiYNlHWDg8PwXUfX8SEkXFfYD+/zQrGsKBhmntQGhR8eIJdgVjs5b
	FJ5OE7bI+Vffb9odbFWICtVJZ+nt4HiOoCOnbyme5nVGwS8GFvWus4hebJAagj6/82Qwvx/XYjw
	7lUw4VS0XYZT7cFb3wDbgpXdYRfbvqQ7bTadMonhUVt8NT3Rm1xQ7NUTQVKEDsq8B5rSkn0tiAa
	DLxpseBni1ORBV8ieOSQI1qwbB8=
X-Received: by 2002:a5d:5d87:0:b0:499:9f62:d64c with SMTP id ffacd0b85a97d-4abaf64be07mr33775504f8f.10.1795541581121;
        Tue, 24 Nov 2026 09:33:01 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989e3sm29248480f8f.52.2026.11.24.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:33:00 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: naush@raspberrypi.com,
	svarbanov@suse.de,
	gary@garyguo.net,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v13 0/3] Add RP1 PWM controller support
Date: Tue, 24 Nov 2026 18:36:54 +0100
Message-ID: <20261124173658.31030-1-andrea.porta@suse.com>
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
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds support for the PWM controller found in the
Raspberry Pi RP1 southbridge, used on the Raspberry Pi 5 to drive the
cooling fan.

Compared to v12, the driver now also registers a "fan" auxiliary device
(pwm_rp1.fan.<id>). On the Raspberry Pi 5 the RP1 firmware measures the
fan tachometer pulses and writes the RPM value in the phase register of
PWM channel 2; the companion hwmon driver, sent as a separate series to
the hwmon list, binds to that auxiliary device and reads the value
through rp1_pwm_read_tachometer(), exported in the 'RP1_PWM' symbol
namespace. This is the approach agreed in [1], and it removes the need
for any dedicated DT node or binding for the fan.

The DTS node for the controller is already in v7.4-rc1 [2]. The DT binding
has been applied by Rob [3] for consistency to v7.4 and is part of v7.4-rc2: as
a consequence, patch 1 is included only to make this series apply 'logically'
on top of v7.4-rc1 and can be dropped when rebasing.

Changes in v13:
- dropped the DTS patch, already merged.
- add patch 3, registering the auxiliary device for the fan tachometer
  and exporting the accessor used by the hwmon auxiliary driver. The
  exported function was originally part of the fan patchset. Since it
  is really part of the pwm driver to be be taken by Uwe, I moved it in
  this patchset.
- Kconfig: pwm module now depends on AUXILIARY_BUS.
- added a macro to define the phase channel number from which to read
  the fan speed.
- removed the 'Tested-by' tag from Gary (see V12) since the patchset
  has been significally changed and need to be tested again.
- the controller private data is passed to the auxiliary device as
  platform data, so the exported accessor no longer depends on how the
  parent platform device stores its driver data.
- dropped the unused 'pwm' argument from rp1_pwm_apply_config().
- added a MAINTAINERS entry for the driver, its DT binding and header.

[1] - https://lore.kernel.org/all/ae9a4df9-b1f2-4f00-ab86-d9cf8d9bc387@roeck-us.net/
[2] - https://lore.kernel.org/all/7c437a10-985b-402c-b3ac-cfa97c53d014@broadcom.com/
[3] - https://lore.kernel.org/all/20261102192302.GA882027-robh@kernel.org/

Thanks,
Andrea

This version has been prepared with the help of an AI coding assistant
(Claude Opus 5.5).

Andrea della Porta (1):
  pwm: rp1: Register auxiliary device for the fan tachometer

Naushir Patuck (2):
  dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
  pwm: rp1: Add RP1 PWM controller driver

 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  66 +++
 MAINTAINERS                                   |   8 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rp1.c                         | 477 ++++++++++++++++++
 include/soc/bcm2835/raspberrypi-pwm-rp1.h     |  12 +
 6 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rp1.c
 create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.51.0

