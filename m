Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501224;
	b=yf3PqCZTojzjoVvjzVu9rpVA9zK9vVWYZrNp13W/3MOgfsZ2cvxkbsc56l2WhD4U6/w/
	 frv9rEDMLp26Wc/h9ektyvSijtJ+EGbY5p6Z++Hhz1SnbiMyQ9G4w735ZEobvdtgjQrKR
	 yLIOuWSWip1QGkf6iT/Id1PUUZw9qyCkmxW9JwYZEtlZbjizprlL2+WfewY0F6tp8y4iZ
	 fTBi+ONhxqXxqxZ+PkJHLf9Kc0w94UDNEVWimQU89B4RMqeXMPigaYcbGCtX5uBrck1z9
	 aWmNKq5hbLQHW79fE//L4u0yoAx0PfMJLfKnfOLOk8NkzG/wDLaXEbng9vfZSeXI3vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7AHNUECT+cdB9/Xcll8wi1ywwKoxcpIfCCZDGgRyrUc=;
	b=Cs9YDqFAR9E/hj+QgA0BtkEbHWUvXA3tsG3L4BS2bQsQyrZ44lfK8L6Ctf4STAHHRQBn
	 MPqtDVt3Pi20naTvCHnjDGzevKvQhK/TAicW4QMrGrPVQrE41u6QopUCOV51Ev3beDqql
	 eBr0PSmV5pTdcydyVL5uYSjlzwIWC00kksAfH9H5arcRL6BVaRNc1gTAIZKPvcKMVEKDp
	 FNtbYrA0fvh4fHBAtXn0A5FUEoI8FUukJWLVmkUdV17FsCmMJVVfSV2bfipAdmtZEa8Q/
	 Wbt+Ks9DgufjzdQ/HnCtMTurMeICSTjuzGi8Jd3IOqCDuX6gvQBWV4lU3bFinBHdtlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E0F7Hu65;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C560A3814
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 13:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590C560A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E0F7Hu65
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so17354375e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501223; x=1793106023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AHNUECT+cdB9/Xcll8wi1ywwKoxcpIfCCZDGgRyrUc=;
        b=E0F7Hu65seHwVdW+FHp3mVrOVZw/FQgWjo23wNhERvnPDPX5w0fuyS9y/+K/1or6AC
         53UmLLzuXH0GmfEXR0ypuB/t1gOwLzBNFXykNEDkIOlFHgYRlyo2RTqsVEFbUEkAqB7F
         CYjn96br5Iz8K+Wh5YFmSKXZRx+8iEZM7Ix/7zGuz4Sgiyt0Y7EJcYfXE4YF5xLNjbMQ
         zB0jun/WZ8oqFSMDS08LmBk8HmP1Ic8HNig6WgKSs4azQdbVwst7UOv9UzQuc4EenfN/
         2OdjzcTCiwtJBA7qncngxvdJ9kA65aWs+JxwYIH5btwWy8w7w4peSoTcfgnL/Lfb7Z/6
         X5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501223; x=1793106023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AHNUECT+cdB9/Xcll8wi1ywwKoxcpIfCCZDGgRyrUc=;
        b=c5BfJcEjeWeiPlcL49Djl4iBsyVe/KnmoaBzf6f34vSfj+yKgIVrpXsyAjQ+lOsm7k
         zbHDpjMHuPev12X01QV5tB7UlzlV8aGuYr/dgsxw3tin83K4VUyl37ct50rXSX5Q3Hc3
         kR0N3NMTg682pFw50KHqxkvC3kx+MABM6ay7/naMBbJzbJUKItAjLX/4KdI3uEyMqkfw
         XuilTh3l31UcYsPw2Fs88N6eoPx+yVQ1F4Qvn20+Rvyzb1h/68ODCBCFo5M/nUrf5kp9
         Rug9mtDLl8m6vay9tUMT6in0itH97tMLjt23GGiDlxHRTygdhuA+rva7viOjPZ1BZ0nf
         qC2A==
X-Forwarded-Encrypted: i=1; AKwUvBwc6jRxim/ukAxjsj6D/03xyYd1T/brzIL7ecuEBgUzGl0ttg+y+fVWhsISqmT14t5UFnAp15nfxKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7wdk8Qw1CpekoBx8d0O/ZmsgkRysFLXS3EgX5t1FoEjAGWLXW
	G+TTKcrg2GzJoukfE2c/b01TEym8A+iX+3M07IWByYROxrzZNNqQHv9Q
X-Gm-Gg: AYBFou0m1IR6FkXOtF52n2VRfIksXtNnJvxJFfd3x9xtprn9IBtcusoYs2NJ8fnhpvp
	zHX8kT2Zad+lrPg8Ntc6E2ClmT28B8PZT75AMyBz+66gyyoXCKIQS/ZTQ+JmPlcQGHW5aVFg8pB
	HOAkhy2HBiQZEHOrSrMWr346ibr8rBfDxOTthY+leaswQM8rkuXP1cYmn6GehOv0bz13zPbw3ZE
	u2GazPFI5gnAXZpIwUNGe6pXHFFnnm4xfpJiamSQTuYwwfG54E+zEOr684k/CJqA2vv9PVwMrEx
	W5IbxFDdViVh+uBfKR/C5jJvPwaV/nz6VIfTWr//IWcL5lsYSPbtvZabUQ3TaXjs87HUVkauSCy
	+9lZ1xR8dH8beYAT6OSc9PZdOjVqwineXoLdeSBZEvW8ApIurskV7LjCbe3KYYPRro9jS+Exmh0
	URUdFq6sb/Azrgqq/yN+4w1N4APHJzxzhjJIrndKf2jNAm4nkFAkwQad3TUvkjNrTnaj6C0sAOU
	J2i4cooFLBC4T4zBFAHF29X6i0FRTwJKT842j3iP4xxf2nQcUlfZfJVdD9rglnL5J/EpLxC5g==
X-Received: by 2002:a05:600c:608e:b0:4a1:e08e:46b5 with SMTP id 5b1f17b1804b1-4a1e08e4871mr164567895e9.16.1792501222390;
        Tue, 20 Oct 2026 06:00:22 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm6114754f8f.54.2026.10.20.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:00:21 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 20 Oct 2026 15:00:14 +0200
Subject: [PATCH v3 3/8] of: property: fw_devlink: Report unsupported
 supplier linking
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-fw-devlink-nexus-ready-v3-3-fd6f1c17e16d@toradex.com>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
In-Reply-To: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

OF supplier linking is deliberately disabled on OLPC and Intel CE4100
systems. The add_links operation currently returns zero on these systems,
so callers cannot distinguish unsupported linking from success.

Return -EOPNOTSUPP when supplier linking is unsupported. This allows OF
unit tests to skip link assertions on these systems without exposing the
private platform-support predicate.

The driver core ignores the add_links return value and marks the fwnode
as processed regardless, so its link creation and retry behavior remain
unchanged.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index aa65976739e1..99381c07848d 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1708,7 +1708,7 @@ static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 	struct device_node *con_np = to_of_node(fwnode);
 
 	if (!of_is_fwnode_add_links_supported())
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (!con_np)
 		return -EINVAL;

-- 
2.43.0

