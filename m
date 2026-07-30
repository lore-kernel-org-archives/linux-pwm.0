Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0403D47B4
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447019; cv=none; b=imdeY+lfc+wMt/MuLzEjhodQfmh7OIymKlXVcDrtsO3PhCSa6yH8T8ahyAD9x6sb0mm51r11CjC9i4wdRhNm9zYQkeZ7uwyK+2n2XEhVYYdoI9n20ZNFMKNMCI3TRKeXZVdse8nVVXA8S3cfMGYHdd9yWVfr2NTfG/eRUVYUa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447019; c=relaxed/simple;
	bh=62lcbR9+Va1j0R9nZb47tv42cOYtl5ojtrYnuKAsAyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XUlKs1ELflUumw9Q/QRtCWJTouqNbKkhPwrPGk08m2SjPePUhDWxbldfhnKkjNXJsBHtP5O1fIOBO3pORhH5BuY+xhj5TFSbcV0Ch8Fg06wp2US+LZ3S81bUcBYk7r/0Lu8uE5lbbg0ct0bK+CsuboyvUEuQK6/TaOgf9703q3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrL6Qn0V; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrL6Qn0V"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so304675a91.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447017; x=1786051817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bwpLtkucjUT6I4TmAoZ2ORiRbxHjHtLbtFrl1jewPys=;
        b=WrL6Qn0V6+Z3zD68YAhL70UD3WVF+Dqt8hHFvvsyHKUnTGeh1sGzxufaKhTsz82w/5
         4ojJ+aD34vqS8DOl3+GAs8YjoGxO5qva3sIIpu0xlvgJNhRCrKiD45aXfUa1zHjvgrAu
         8LZJeVF2w/3tUGZGPbPhqC6GsQVPH6XaxuueDSaH55OKGLJK44caJQ3iU9Q99IWkumaS
         IKRcgWqehI8ykKLMmYe4akjf7RpqeWUsJoLFEA2aQPAkcCKPsalEEpokYTkFGKZ6t8o+
         SquWweYhIMvR0b2s2A9ZJ1p3ZBOz7EpwZ65iqorNFT+KJB/S+htheQALLSvYy7xWnLyJ
         XRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447017; x=1786051817;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bwpLtkucjUT6I4TmAoZ2ORiRbxHjHtLbtFrl1jewPys=;
        b=Pbh4jAcl3+FPNPCxtn7pLYXsYom4CRJdJdRNzaNG8fZKG3kYo5BtZAbnt1ArFVWEUU
         ivcsmmlnqR/W9w4ThLXowvnaoZoae64We3QT8WQIOcHxAe9CNk414v5Dt++foUmlWDpG
         YqKhjiMZKBfmZX/0p6kMFB+0SnmLCqxlyJPsJ60/SLOxqvZbPm6UxWDRQzGBR4RBTB/7
         WWe3fXhwKWh+JLSV4D2YYE+tz/7qP+UWiPLtRw7Ib46CIOq92v1U7HGFb227Oc4glMIk
         BPJJGDWYRY9yKPCieqE11g/xbhhB2Iz8EiIpKpn9LrbXXtzG7y2l7swlyyCw8QsI/K+S
         +lIw==
X-Forwarded-Encrypted: i=1; AHgh+RpPdW/jqV2+k/lMJDA2fTh0R08hKN2/Bp7bIOD2/v+JZpfc/pFZGcuTnSXYI4O2it5/qInDz7m2hG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdeR7hSmtu0Oh4vhatO6iM/yP/cxeWcdMKCCc7bAwql4gZISr
	7KFNp/MjfESCa77fYHGq+QEAjx9XeD+jzYFcCMF9wuxwtgFNGEZcbzyv
X-Gm-Gg: AR+sD137a1CYNfx4ejdDkoP7pMR2Y5JJRuX9yQfRF0U2yIENqZHahoWA8h3b/3zH39K
	f9u1bCuIk1CUJNILROfZxMvq3sRov0LAuBOso2rNim0aeBW/WA3X/rB0Odx7IbRNhMHIvhg+Acf
	9aMOYb6w0SLzhy4c8aPNb1KfFA4RpNm0uR7LGOTXVdfN6EjKE+ov+FR0cuZNPOGcMKLaeQ6clNh
	YaCCIyPpXRmMi67iZoaxS2P199bmsVbDuMh5Xk0jLu6qKLAVwkXpAvx6MPq+LLw3ebDDmGqNHDb
	i5HfSZkJKTWXnTe7pLirdZ231igemnCVroGbsRWZm77BZkcLn7pXKUjYDBxTfNux1ALSZqQFVYO
	+bTYkzLYqxDaWbvPRzbtcv8QV21TORPV2JAUFUIpUbAdozKXxAa4U+uY4O3FASj5f2vdoEWn1fh
	xLdj55rJY0S+3mQhlAjFJEOuPuTpLFnnghr0KOr91aQd4Ns+v/bUcm+Ofh/CGT+ie0UkR8QzB4g
	aKD
X-Received: by 2002:a17:90b:394b:b0:387:e0db:bc24 with SMTP id 98e67ed59e1d1-38f9c09984fmr3332390a91.36.1785447016666;
        Thu, 30 Jul 2026 14:30:16 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm28584728eec.21.2026.07.30.14.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:30:15 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [hwmon-next PATCH v5 0/4] hwmon: (adt7470) Add PWM provider and
 thermal sensor support
Date: Thu, 30 Jul 2026 18:29:55 -0300
Message-Id: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFPCa2oC/33RS27DIBAA0KtErEMFGAzuqveooorAOCaKoQXip
 o1892B7Y0VWliNm3ny4owTRQULvuzuKMLjkgi+B2O+Q6bQ/AXa2xIgRVhNJa6xtllySr9xB7PX
 lP3jAotGUMCaVlQyVyu8IrbvN6ifqfvvgsYdbRoflLV2PZzB5YqfszqUc4t88wkDnmpfdBooJN
 kYIaCsB1sLHqdfu8mZCP3cY2NqQ2wYrhhaCctkI1Wr7bFQrg6ltoyqG5ULVXCpjj/rZ4Guj2Tb
 4tAvlpGpsqwnUa2NczhXh51r+JS/3PIzjA3yxf9e1AQAA
X-Change-ID: 20260716-adt7470_thermalzone-59a102278d72
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

The ADT7470 is a temperature monitor and PWM fan controller capable of
monitoring up to ten external temperature sensors and controlling up to
four PWM outputs.

Currently, the driver exposes these sensors and PWM controls only
through the hwmon sysfs interface. This patch series integrates the
ADT7470 driver with the kernel's thermal and PWM subsystems. This allows
temperature sensors to participate in Device Tree thermal zones while
exposing the PWM outputs as generic PWM providers for consumers such as
pwm-fan.

Patch 1 adds the YAML device tree binding documentation.
Patch 2 introduces the ADT7470_PWM_MAX macro.
Patch 3 registers the four PWM channels as a generic PWM provider.
Patch 4 registers the external temperature sensors with the thermal
framework.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

---
Changes in v5:
- Hide hwmon PWM sysfs attributes if "#pwm-cells" is present in DT.
- Register PWM chip before hwmon in probe() to correctly initialize 
  sysfs visibility.
- Fix waveform rounding math to strictly satisfying CONFIG_PWM_DEBUG
  expectations.
- Return 1 in round_waveform_tohw when the requested period is too 
  short for the hardware.
- Link to v4: https://patch.msgid.link/20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com

Changes in v4:
- dt-bindings: Dropped redundant descriptions for standard properties
  (#pwm-cells and #thermal-sensor-cells).
- dt-bindings: Conditionally referenced thermal-sensor.yaml to preserve
  ABI compatibility.
- dt-bindings: Switched to unevaluatedProperties due to the imported $ref.
- Link to v3: https://patch.msgid.link/20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com

Changes in v3:
- Migrated from the `.apply` callback to the PWM Waveform API.
- Moved fixes to another patch series:
  20260727-adt7470_thermalzone-v3-0-21424d550c3d@gmail.com
- Use guard(mutex) for simpler locking.
- Link to v2: https://patch.msgid.link/20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com

Changes in v2:
- Fixed 2 previous bugs uncovered by Sashiko-bot during review.
- Dropped the thermal cooling device registration for the PWM channels.
- Implemented generic PWM provider support using the PWM subsystem.
- Updated Kconfig to safely handle the PWM subsystem dependency (depends on PWM || PWM=n).
- Updated Device Tree bindings to require #pwm-cells instead of #cooling-cells.
- Link to v1: https://patch.msgid.link/20260716-adt7470_thermalzone-v1-0-cc55ef35edde@gmail.com

To: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: Andrew Morton <akpm@linux-foundation.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org

---
Luiz Angelo Daros de Luca (4):
      dt-bindings: hwmon: add adi,adt7470
      hwmon: (adt7470) Add ADT7470_PWM_MAX macro
      hwmon: (adt7470) Expose fan control via PWM framework
      hwmon: (adt7470) Add thermal zone sensor support

 .../devicetree/bindings/hwmon/adi,adt7470.yaml     |  58 ++++++
 drivers/hwmon/Kconfig                              |   1 +
 drivers/hwmon/adt7470.c                            | 203 ++++++++++++++++++++-
 3 files changed, 258 insertions(+), 4 deletions(-)
---
base-commit: 4c2e8c377915496fbe9cc1c9d91a7297aaa01783
change-id: 20260716-adt7470_thermalzone-59a102278d72

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

