Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541720;
	b=n6Po3qD4eCR0erWfA3adAB+EhVhH+6x5pJhkNu3kDMFLXdT/HRf73ppnXyoUnRQ8O+yg
	 CPG6UTtb/YKuLeNhCPaUOhvBLqvehZvmsoJ3g/cPSShEJqcQIZSBbTWS81QfkZpYj0W7V
	 wcZs4Zqvec/xudqsSN0hjG4pr/GHAldSZM9B5mmJiNFKYv3kpdjAqscIssA8leXqDwYUu
	 b/NHwztYQ8jJutcsvXjFr1j5FA0CVsPGP0SzMfQt4aWNEG4H6nqMTa9h5nxzo8d2PCJhr
	 Unm5pzzpJ3v7wcZf0+pBejLXb2FEX+5FMW8uCtRBJDduuLcgnLG5MSzjEEcUAinztoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DmBwmrmEWgysYKtSDSRrr9hV9wxgIOlNWVL3lTij1CU=;
	b=U66QIl3JKIA7H54a/+gx4GoQtSBop1gqILDznrGzZ9rvGKc2n+rbGvRDWwPKs6EpvItn
	 lRjYNNZ5mElf7zA3pChO8DamEcXll1TK9rtdHYzQS3pqOAETXjFFB5nKisgCodrbTMC1t
	 QkBU1srJF6a3y3QFL6KBFCF+H2E0bwrmp2UtYJWiH0Lkr5fJpVbqdRnkk/3gc54a4alb1
	 IT/+6BIPu3ct1oRaf0s7LAzD3CVUsIJGDd8IoN1RU9U7zwL9N4+/rGpgE66UNJXchJlMF
	 bMRmeuKUmWJIRka6xDALc7qMmydduZ0d5V1bgc2mNpvNReEOtiwqZXth8pPK055SdkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="OmDIg5/y";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0E606A680
	for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 17:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E0E606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OmDIg5/y
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d05d51553so35092935e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2026 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795541718; x=1796146518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DmBwmrmEWgysYKtSDSRrr9hV9wxgIOlNWVL3lTij1CU=;
        b=OmDIg5/ygmndD+Kv5JZu155dClMlLF1P+Gd3Gn+MXXxkkH9P++zAq0uJKz7MJzb9Ep
         9GAOFzNT1AiHFEb6YOH7An1RM5Kq3wKKivuk4nuQ2F26uGAsn26+eKf47b2vNUBiLy2o
         yP7/7A+G9S+n+sSz5kEIYc0UjZhSJvbHU/YoXUjrUU1PrBb0qhXyaiW1jNz3XiXKNMPJ
         ftLnedCmAW9WeUTEO1ihLGasy5eI6rs360qul+IGcrXJSktAlmICnamarnC/z0xWRbud
         x156i62ARhcbuRiMmhd3W+b9uhcIWJ0YsWm3wC7Ad+cY1/U/8deDAuJYKwx5DiRFMU0f
         pJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541718; x=1796146518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DmBwmrmEWgysYKtSDSRrr9hV9wxgIOlNWVL3lTij1CU=;
        b=zqLu70LFwwgOKa2De0aG5qNbi67sz3eOrsHCDxSCV0GQAoKd6wZq4XFd9TIoXxQehF
         i8/uhru0aQ016raL2G2HPziLkTW9lJi51KQ+0X+377LO1evPSoreZvzwypbVpUWHnNtn
         RTl4iOBpVdSKyO+yEcpICc01mZO8+gu1zaOHWgKTkPzuGKbaccvW2FBulKyYt/jqv3tV
         7xOt1prQuUt7JR8hnk3rULOJu3/cC5/YergMnvgufkKdEN+vxIBYlSp3y0+QNlVakQzU
         A97RrLW4hLSss/5agC5VmLIwvrb+3G1IxnQZeg7JkJdHWxViqLAz2e2WIPwoZNs0+QlM
         MR0w==
X-Forwarded-Encrypted: i=1; AL+hErE8Mk7yaq8GThAjGQQrA6Gl2Zrt1t5ttomqfgxtXQVUoPmL3M9NBXy6/UT65H7o1dWDVZJigQHuXXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gED8JaFczEXP6hWGVDh3KAwzZrSs5BFyqJO3jnVGviT1cySDU
	TiM+iXPv0jI2rwbLwmAQFzcDSO7u/WzrhK3p/pYsCnKD+tyCKqZpCeLpvS9xyNSY4SY=
X-Gm-Gg: AZFdTZdOLMdNtzcZJA5g8bQC/LDizO0OBfdRY8AV99pyE4MaXh1KCaYrJZvXlNTbNoK
	xf7HfCB0ZxYxk7yyY9MFSGkfRPAlJ3YvN6UwdLChgAwpg3v2MmsW5idVDdNafgGvoz4yYrJzSUb
	8BBILfJX0omBzK8J1pNUZPXAW3uphKC5Ma6Oh+pFSzNBAfI8GBsV/wV22Fmw+txNU5EWZF7TM3B
	2CJ68qu+Ib29iuu3+a8lSd3s0UdyutvDGigmAM/w7DJW+u6KVjoJIVak9/4tk9KLesBPLpBBQAI
	lwuANfaRuLueXFXgQ6UspX/6c841+KRBBQZzG0tXo2NXVe8Eb0RSjioCVXELrdXUmXZesILVS8F
	br2fA7Gz5M00YE8mXGZ7DKNN3G7owVEeMnl1JiSYRlDZQATRymSGunZRdiZ+60Dmi45VI+WF9HK
	9CCo51q2Zu8B1oSNJyqMDaijOlQspykYbGi9+rychJMzbMLztqQd+JHF3dWhDOCQswmCi67tYLa
	ngclA8ofbGQB2/ld6z4/SlXN/c/xm+jpAF9X5KT0sbhj6p1A4NZx6ALUKbphJK8Ui+Z/z1MBpy6
	VZyiYA5C/2qfaSJW8kmc1+HIIxQ=
X-Received: by 2002:a05:600c:a08e:b0:4bb:647d:dabe with SMTP id 5b1f17b1804b1-4bb887c3afamr345794445e9.3.1795541717677;
        Tue, 24 Nov 2026 09:35:17 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm460171975e9.3.2026.11.24.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:35:17 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 0/1] hwmon: Add fan tachometer support for Raspberry Pi RP1
Date: Tue, 24 Nov 2026 18:38:59 +0100
Message-ID: <20261124173900.31266-1-andrea.porta@suse.com>
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

This patch adds fan tachometer / RPM monitoring support for the
Raspberry Pi RP1 southbridge found on the Raspberry Pi 5.

The fan speed is measured by the RP1 Cortex-M firmware, which writes the
computed RPM value into a register of the RP1 PWM controller block.

Following the discussion on the RFC [1], the driver is now implemented
as an auxiliary driver: the RP1 PWM driver registers a "fan" auxiliary
device (pwm_rp1.fan.<id>) and this driver binds to it, reading the RPM
through rp1_pwm_read_tachometer(), exported by the PWM driver in the
'RP1_PWM' symbol namespace (as suggested in the auxiliary bus
documentation and agreed in [2]).

This series depends on the RP1 PWM series [3], which provides both the
auxiliary device and the exported accessor.

Changes since RFC:
- converted from platform driver to auxiliary driver
- dropped the 'raspberrypi,rp1-fan' DT binding and the DTS node: the
  device is now instantiated by the PWM driver
- dropped the DT phandle lookup, device link and reference handling:
  the auxiliary device is a child of the PWM controller, so the driver
  model already guarantees the correct lifetime and unbind ordering
- rp1_pwm_read_tachometer() now takes the auxiliary device and returns
  the RPM through a pointer, separating it from the error code
- Kconfig: depend on PWM_RASPBERRYPI_RP1 without the COMPILE_TEST
  alternative, fixing the link error reported by the kernel test robot
  when the hwmon driver is built-in and the PWM driver is a module
- removed <linux/mod_devicetable.h> and the other unneeded includes (Uwe)
- updated Documentation/hwmon/rp1-fan.rst to reflect the changes
- added a dedicated MAINTAINERS entry for the driver, instead of adding
  it to the RP1 PCI driver entry

[1] - https://lore.kernel.org/all/cover.1792748690.git.andrea.porta@suse.com/
[2] - https://lore.kernel.org/all/ae9a4df9-b1f2-4f00-ab86-d9cf8d9bc387@roeck-us.net/
[3] - https://lore.kernel.org/all/20261124173658.31030-1-andrea.porta@suse.com/

Thanks,
Andrea

This version has been prepared with the help of an AI coding assistant
(Claude Opus 5.5).

Andrea della Porta (1):
  hwmon: Add driver for Raspberry Pi RP1 fan tachometer

 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/rp1-fan.rst | 43 ++++++++++++++++++
 MAINTAINERS                     |  7 +++
 drivers/hwmon/Kconfig           | 11 +++++
 drivers/hwmon/Makefile          |  1 +
 drivers/hwmon/rp1-hwmon.c       | 78 +++++++++++++++++++++++++++++++++
 6 files changed, 141 insertions(+)
 create mode 100644 Documentation/hwmon/rp1-fan.rst
 create mode 100644 drivers/hwmon/rp1-hwmon.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 8a9c7c53e94bfc4dd1dc40e8277f22c1f410f404
prerequisite-patch-id: 3053bded44bcd6a78ecae5a255ae876c5a9cb49b
prerequisite-patch-id: ade915a82dd15722ecb44802d307ff9d60a79228
-- 
2.51.0

