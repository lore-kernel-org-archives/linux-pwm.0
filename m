Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F534BA20;
	Wed, 22 Jul 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706092; cv=none; b=uA8grHVJBJN1sa8z1H8kkoYycuKr3fKo7Fe06HMdByH9L5/VoJfbkEhsqm53sDVVEt9OxJMsSxOpyv0bdHFfgJ1GuNANnNX/pIH1Vyh5P6gVbjN0yRPWlwwSv5pDxeLOTWhoc68zsap6QBOuox9NgrYu+cNvaGXlz9+XHEZ+fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706092; c=relaxed/simple;
	bh=72bcOySU+qcp0rVUzo5OLqZ5guS5TZ3U+1yM97Ebweo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ty/BR9NCoUuqPNXBkEnPvuO8W+NFAzPsU2pGRwdw/OYEMaucKKGBBD8L7q3aajUB3naxRU0lugpQSrTDAqpGq33GFDxyMJ6UBC4kOl1Nz+fVJIAf53xZKJ/EZ2btwOS0M7Y7c4zRpNBaeaohKhpTXpUKlnFROu233GEdyi/pTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 22 Jul 2026 15:41:12 +0800 (GMT+08:00)
Date: Wed, 22 Jul 2026 15:41:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, ukleinek@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@kernel.org,
	tglx@kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	"Conor Dooley" <conor.dooley@microchip.com>
Subject: Re: Re: [PATCH v12 1/4] dt-bindings: pwm: dwc: Document optional
 resets property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <08d7d89c6b373365555571d29a97b132aeb4fc0a.camel@pengutronix.de>
References: <20260721120757.1134-1-dongxuyang@eswincomputing.com>
 <20260721120833.1192-1-dongxuyang@eswincomputing.com>
 <08d7d89c6b373365555571d29a97b132aeb4fc0a.camel@pengutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74db8e52.8900.19f88c57dd0.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ8YdGBqOII2AA--.7724W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQEQAmpfnycZA
	wACsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBPbiBEaSwgMjAyNi0wNy0yMSBhdCAyMDowOCArMDgwMCwgZG9uZ3h1eWFuZ0Blc3dpbmNv
bXB1dGluZy5jb20gd3JvdGU6Cj4gPiBGcm9tOiBYdXlhbmcgRG9uZyA8ZG9uZ3h1eWFuZ0Blc3dp
bmNvbXB1dGluZy5jb20+Cj4gPiAKPiA+IFRoZSBEZXNpZ25XYXJlIFBXTSBJUCBoYXMgdHdvIGFj
dGl2ZS1sb3cgcmVzZXQgaW5wdXRzOiBwcmVzZXRuIHJlc2V0cwo+ID4gdGhlIHJlZ2lzdGVyIGlu
dGVyZmFjZSBsb2dpYyBpbiB0aGUgcGNsayAoYnVzKSBkb21haW4sIGFuZAo+ID4gdGltZXJfTl9y
ZXNldG4gcmVzZXRzIHRoZSBjb3VudGVyL3RpbWVyIGxvZ2ljIGluIHRoZSB0aW1lcl9OX2Nsawo+
ID4gZG9tYWluLiBUaGUgZXhpc3Rpbmcgc25wcyxkdy1hcGItdGltZXJzLXB3bTIgYmluZGluZyBk
b2VzIG5vdAo+ID4gZGVzY3JpYmUgZWl0aGVyIG9mIHRoZXNlIGxpbmVzLgo+ID4gCj4gPiBBZGQg
dGhlIHJlc2V0cyBwcm9wZXJ0eSBhbmQgZGVzY3JpYmUgdGhlIGZ1bmN0aW9uIG9mIGVhY2ggcmVz
ZXQgdG8KPiA+IHN1cHBvcnQgZnV0dXJlIHVzZSBvZiByZXNldHMuCj4gPiAKPiA+IEFja2VkLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gLS0t
Cj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRpbWVycy1wd20y
LnlhbWwgICAgIHwgNSArKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
PiA+IAo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbAo+ID4gaW5kZXggNzUy
M2E4OWExNzczLi4yMTNmZGFlZjI1ZDkgMTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwKPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGlt
ZXJzLXB3bTIueWFtbAo+ID4gQEAgLTQzLDYgKzQzLDExIEBAIHByb3BlcnRpZXM6Cj4gPiAgICAg
ICAgLSBjb25zdDogYnVzCj4gPiAgICAgICAgLSBjb25zdDogdGltZXIKPiA+ICAKPiA+ICsgIHJl
c2V0czoKPiA+ICsgICAgaXRlbXM6Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZXJmYWNl
IGJ1cyAocHJlc2V0bikgcmVzZXQKPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQV00gdGltZXIg
bG9naWMgKHRpbWVyX05fcmVzZXRuKSByZXNldAo+ID4gKwo+IAo+IEkgc3VnZ2VzdCBhZGRpbmcg
YSByZXNldC1uYW1lcyBwcm9wZXJ0eS4gV2l0aG91dCB0aGF0IHRoZSBkZXNjcmlwdGlvbnMKPiBh
cmUgdXNlbGVzcywgYXMgZHJpdmVyIGNvZGUgd2lsbCBub3QgYmUgYWJsZSB0byBjb250cm9sIHRo
ZSByZXNldHMKPiBpbmRpdmlkdWFsbHkuCj4gCgpIaSBQaGlsaXBwLAoKV2Ugd2lsbCBhZGQgYSBy
ZXNldC1uYW1lcyBwcm9wZXJ0eSBhcyBmb2xsb3dzOgogIHJlc2V0LW5hbWVzOgogICAgaXRlbXM6
CiAgICAgIC0gY29uc3Q6IGJ1cwogICAgICAtIGNvbnN0OiB0aW1lcgoKSXMgdGhpcyBhY2NlcHRh
YmxlIGluIHlvdXIgb3Bpbmlvbj8KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcKCg==
