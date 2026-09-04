Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2038A711;
	Fri,  4 Sep 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524434; cv=none; b=tMKR9PY5DuHju6UMLNiDamany67vEEtlaqtf2PxZoza26/fqPjDroxobsJKo1dzZs5labCWCpjMtasUBOnUBBDJMKlDli5rutAUwJ7/RSlLP1+FHM8CpKL0cOSwnfXbrStKdpEOVW+u4QvBxQDA0Mwb1anlZVWzZdk66mZbMGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524434; c=relaxed/simple;
	bh=ga13SdaC+9RUiJKd0nsSQAyTik/AEl8ul0joNLy7xI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3x5QVIi3uM+32a8CAviCBytSVypDJ8K2LOYVQECbK6AJzkQCkRIceHewaXLdzcFfJUheBqWR+8RV5QCewvJhqlTv/5YGShEJTxdQ3fPkQpHYuJ1qPc/60d/gmex3zipgNGi3H/pVUZaeLG518ozirYEpGfi4bQaGs0c/rNDN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oUS2QLGi; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bhAZSq8g; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oUS2QLGi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bhAZSq8g"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbwXZ342fzMlKj;
	Fri, 04 Sep 2026 14:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788524430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tlh6QFyXLDMrX58MEQiMC2jHV5MzH5L/pldpXGnUBh0=;
	b=oUS2QLGiTIgYEb0UydSlgUGqRhjZ9qsEEWTviEvWbwSviX/HcuitUHp+yFGsic1+C1e24M
	aYTF0Zkh+wQ44eyMWaWkiFlmBbZ/cZLT4yBMzT/zYcEYOnCWEe0uP8NTKmltFzgFi0G/sl
	mC0sZqIQGogo7rXaG6r9XUtQjv8XDXWwWtGP19o/esYLNx+gbfaeWwp5VGQUrMVNDnqaZS
	NFoq3ZP2i8AQBh/BpMEl5sxM+pj1MO7xmZSsyD0F+1IfFxKsl9qeIhtE3+v0/eZW9AXAO6
	+BkcKn1BsqZ87iylKok9jIz47eSTKztwrd0NwqEEVhcOl2f/zUXUrJsBF7jUDw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bhAZSq8g;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788524428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tlh6QFyXLDMrX58MEQiMC2jHV5MzH5L/pldpXGnUBh0=;
	b=bhAZSq8glyn5LE3oSbJMsHMvKG8XQfexErSauX+260IGCRtWvcVONnC2MTasHasS/Wp6ZH
	0OBx4PoPGDzDlMjLuyCummWz9nO+OF4HsVeGGMJXvzTvo5nDCyZWMgubRYLGxmsyWStowa
	/cmPE1WW2PXsC0RJzRxXR6mDCvFzwcMBaHZZmkagdWoF7pcf6U2u0OvMhQK5te3q6I4sl2
	qOowhglO9uxt1rHRyRsl/X8cjVBnNYm05t/62cvOTAa3OuZ7KKeDDv8UJYj238AjQNzPrs
	HGQAjfQB/LrlarYwnaXusU6ZCjC2Za7F0mip6dpTgwIi55tlz11ufgtpM10sSQ==
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-pwm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: pwm: Fix bracket and punctuation
Date: Fri,  4 Sep 2026 14:20:04 +0200
Message-ID: <20260904122005.760299-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 93yfjiqibchk7qa4j14jtktxdppy8edi
X-MBO-RS-ID: b14c66cde324463f3c2
X-Rspamd-Queue-Id: 4hbwXZ342fzMlKj

Remove needless '(' and fix comma splice.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
CC: Randy Dunlap <rdunlap@infradead.org>
---
[v2]
 fix comma splice as Randy suggested.

[v1]
 https://lore.kernel.org/all/20260903160535.734369-2-manuelebnerli@mailbox.org/
---
 Documentation/driver-api/pwm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 0d27a40f5..b6b67f7d4 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -177,7 +177,7 @@ and pwm_put() may not be called from an atomic context.
 Most functions in the PWM consumer API might sleep and so must not be called
 from atomic context. The notable exception is pwm_apply_atomic() which has the
 same semantics as pwm_apply_might_sleep() but can be called from atomic context.
-(The price for that is that it doesn't work for all PWM devices, use
+The price for that is that it doesn't work for all PWM devices. Use
 pwm_might_sleep() to check if a given PWM supports atomic operation.
 
 Locking in the PWM core ensures that callbacks related to a single chip are
-- 
2.54.0

