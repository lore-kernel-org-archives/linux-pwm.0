Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F1448B8A
	for <linux-pwm@vger.kernel.org>; Wed, 26 Aug 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756010; cv=none; b=ZFM1hYgQXsW16XicaZvtZYD0bDHxcYF/eSJLchg5PpN2LWA+9gDfJ1gfRdqECcptsWssRQXjm/PBEzXApbHFjPqh2ptHMfw8zKotzN5MaqZExaNJ1r+of51P3wKdKNAdOs6h7RRiIwqM8pQZibxrx2gKTDZ83CF+w3ybCghuSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756010; c=relaxed/simple;
	bh=vi3S6o/aCX6InBuOsTN52Sk60siVGMjgF514ONXxk5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akUBqYlGeGZkLvLCVSpF174AOYdKiLnLyDx+lCrhkbpCk1K+OmTrNAwJ2qbn+HDUNg3dKlBRcLM5msWHWKUV3m1hsEu/QQPz6JTQfbz2xRskL/8AyxcPCzBf0R774KBcDmxSZJAc4AITs0VqL3U2C5hloBj3AulF/eban0F7Jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXAWjUO2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWivV9d7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXAWjUO2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kWivV9d7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuYqW2148522
	for <linux-pwm@vger.kernel.org>; Wed, 26 Aug 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=; b=ZXAWjUO2tCeY5iwi
	MWAoRQf0doU2qOQ52qZIaqbuhIWW1zYZY8f1F2/dZLVh6r/kYQ33yTHtGcfIybWu
	gvEPOHRjXMeWGI9HO7iWY/TytmwvQdlDuKQdEa6RzuG2lIK/I5Gq1fXS0u8pxhuo
	7U9an6EY2n2ZnldTRjEN5iLiZ80LHC4nmA/gPREAAjXmP3bVHCI6Btbl75nj+Dex
	EGoFVBCwwO+DvjGuw0ZVb8VOtmtd8wpSfNLxru2akPB0QI96nQrj6dRk7DUWG1L/
	UFvLOIBVv1328lLjlkq+Gx8kakdDia4bHESmloC9z3yHNAh7U+Dxgy+9LP1nY5K8
	LkoopQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1ssry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Wed, 26 Aug 2026 14:53:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52827090cc5so10697711cf.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Aug 2026 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787756002; x=1788360802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=kWivV9d7k2ygHReaufVlyxC9yHUpYPZaZAxSR0nQzK8r1cRyyB/JlCNJuoldCGZb0v
         3pV+Y21AO+g/qXwMOBbhvE+5Ww/B/xyaZdGBRRj2aDz/kZfntxLc3SGBaInGQkOqxcJL
         iUyPY6mEB0dLFfLQFZG4l/B8jCrq3+QEZaMJca0tELZ0UPMEi5TPwZxnV75ZTwzwmT1Q
         O2GBmx4lN6JQXAc6ne+gqMZrqpXrVyr6n4/a2rj47EdQqH5S6HF+rG/aVb0CGX825zNy
         8sPqhebg1T3rN4WLJjK2Tdz/87UP5CO1fBLoLUbBjpWUOTiC1RalxLw0ngNDwpmJ2XGW
         s+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787756002; x=1788360802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgITQOLCNa8poMm2HFJ4MO8AYZclvE5sM2FJ5XQeS38=;
        b=gbW038mty+KNa6VeccCXCDFNd6pFjzaMpK1CrsIaUKsIFTy9l4K6CVjfH2drtmP8QE
         G9wfMoI1oN7TShbxueQax7ThNls2XbhUt9SoLFkEX9O8rehjFZAHQ1Y+5KJjTXMPRGFi
         QisjOA1RFuO1e5rnXAKMHmXX7Oo519aTUDm925IAeKX1FITyemwFrNxtJGCsjL3TCXMJ
         B8oyDzvyLVNZrA2U1oa/EV5IrGOS2Ifc2h6igTGDJjz9iEEElv3rFnPzblJdS7Zkcx8y
         JDN7R7UlH8C3FoNU6rpWwxbsugxecMoTFMdZ46/DrbevtPFztlzELdrbYGI8/jmeISkk
         rLDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9amsz5QZ1MFXi/GwB2hfavFzGBq3EIRj5ncsfmoZrvJDY2FTYrHEVE84eTCrtXUyPip8+GaZ/chc=@vger.kernel.org
X-Gm-Message-State: AFuF++lLwJb0RR/0wuh6Xqj9R3nwD/ZmXe91T/ZE0L8bUSP03KC1bW3Z
	66HEyKf8mHqa8H5Yen1zu0BswpwdRsdmURNxSLpY/aLcee7dydEplMJl637WTwohkTvvT1DlkEb
	LoIMfGp2TZEk7w7q/O7wJM1YiM/JXJPx3BoIfAMojdF4Eu+tkefszmvIfHRB2gkY=
X-Gm-Gg: AR+sD12HlL8h2uL7Q47UvrverJfnogRPe1aX/9xwtKZF5mxyBofBAMDMUPncyXE6dF2
	WWJAibOut1mf2GLNUHWlfptOBuBroKAJeqfRXmkKSPgK1W0h+4R3RHsQ+/HGii+raCTKP7Gz+32
	E/cbS7aB7Jodxd2ITT6vAGfi7C3MGsGP6rXm9lGiY1cOLBhvRTyxoYtcL7FzBTjEwSrZrujgnAx
	pQ+qwjXZ+F0uXO4LwpIiyS5xaL/+7KZftA6M/CySAIWDTNHb5KhyAC9C6vg0UuRrjmstzUkKRk6
	Z2DdcBcnIDi9LGOyzPgbBMLSPdWgzH0jl43hpjhK22WhmbR7Gf5gv0OhIYliRydeZGxjBJ9/B7i
	kyMy8qFYxQm6W3Z8Tke5I7/RC70M=
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172470261cf.11.1787756002095;
        Wed, 26 Aug 2026 07:53:22 -0700 (PDT)
X-Received: by 2002:ac8:6f05:0:b0:52d:d12c:3ee0 with SMTP id d75a77b69052e-52e2ecc086fmr172469401cf.11.1787756001627;
        Wed, 26 Aug 2026 07:53:21 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc3f5sm2972592f8f.21.2026.08.26.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
        mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
        laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
        nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com,
        hansg@kernel.org, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
        ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
        kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org,
        pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org,
        kees@kernel.org, saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpica-devel@lists.linux.dev, Eliav Farber <farbere@amazon.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/13] notifier: add device-managed registration APIs and convert drivers
Date: Wed, 26 Aug 2026 16:53:17 +0200
Message-ID: <178775599400.65906.5565986908119438731.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KWpCxwXgNEDQRJlMWVIbuDavBWQCZYys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX2pt0nltwAzKv
 SFt5a6kZX/5Wa4/lQESptwGvtw6VG3VwFy90qcM8XXP557D/orO57WBrHcdR0Vmyz0bCHi/yCMr
 BlOtkeJdAy34QTzLGRjiz1y1YRMVHvaFSEPzsVz+4xEP4+5cCGzeb1T8u3cS4x7pbdGE2ttvL2k
 RRUHopFv0wQxv+IVRHcDZzL6jF3lHkj+eVE/uztGUqcL5CIv5OLYLEMfhn+khxz4PrQo7igRmYV
 mtxv2Gh1eSGJ+M9E+mgk8NN7VjzQl+S5gKY4LG8gXU19weMaBtolaIqB+xbCJ10y8HkEifXb+Dj
 i4GntKT5gj9rsECidXVwGoBoDtv/CzOPNJPnxv3ZFKcFwWyyghPaa/WUdc6TTa0scWhWG9KDvns
 GwyyhiGHXP/sv/xFlrdZDaR4Wu1jNL2hL9uoXiLEe1owpyJuVaUP8eOayOcB4itIUSylTtG4sqa
 nMizH75CF4Jq2BqKG9Q==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8efde3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Oj9lYo1IyMao6333VE4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: KWpCxwXgNEDQRJlMWVIbuDavBWQCZYys
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX4v2p9qeEHWt6
 DaN31+vxL0SSTTiwetNbQ+sf3i96uYKM65sN4X9IldVh21h24j5mom3d/zkOenyyq+ow+knS3sR
 +99nKtbpUwsvQtdfEirCwllLPQhwREw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124


On Sun, 16 Aug 2026 06:05:59 +0000, Eliav Farber wrote:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
> 
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
> 
> [...]

Applied, thanks!

[05/13] gpio: adp5585: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/870f46a42afdc65d39587d2c56cf35eca294d201
[11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
        https://git.kernel.org/brgl/c/32390690610190f63a31f92ca555077f7861657c
[12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
        https://git.kernel.org/brgl/c/df6501bf6fc4b16c9f502a7ab8e785ec91f3f7e3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
