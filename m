Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE42EBBA9;
	Fri, 31 Jul 2026 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480090; cv=none; b=vAljOBZPEoKXNBBD6CVxeYU10x42DMOexAjoxOGdEDOBaetTBtvFp9jjvpyosL/+wRLq0mxargpleaD71pyE9xoJLXtzsgPdzwHYYZGQvDY4/ebdzB407pXrIAW7u4xh3ArvWhAx84afB+Zk15ibTTBqE6QsO/fvdb+DtLUCt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480090; c=relaxed/simple;
	bh=E3lxYceNke53WS6IbZJ5f1DRimD+ZbDt1yVJxiCHGzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bG55P0YIPOQOLB8WWoIQaiMZDJb7rCEZqCATd7t9PKJFMR7sM+OzSnRnhGt9U9hk+qryZbypCYUgbTJvGmKsrdJUVXB1J13isF137mgkP+1RxIMcvXDPPJ0QcAjT7k2DyxtTU9gqbcclYjZCyJZYR4tzzpr+HH5C5XpTDSKrtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 31 Jul 2026 14:41:12 +0800 (GMT+08:00)
Date: Fri, 31 Jul 2026 14:41:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: sashiko-reviews@lists.linux.dev
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	daniel.lezcano@kernel.org, tglx@kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v14 3/5] pwm: dwc: add of/platform support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260730113930.8FC151F000E9@smtp.kernel.org>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
 <20260730111553.1886-1-dongxuyang@eswincomputing.com>
 <20260730113930.8FC151F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f87d06f.8eed.19fb6e7ce66.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPJ+IQ2xqEfA3AA--.8298W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQEFAmprfKgUQ
	wABsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIGR3Y19w
d21fcnVudGltZV9yZXN1bWUoKSB3cml0ZXMgdGhlIEVOIGJpdCBhbmQgdGltZXIgY29uZmlndXJh
dGlvbiBzaW11bHRhbmVvdXNseSwgdmlvbGF0aW5nIHRoZSBoYXJkd2FyZSBzcGVjaWZpY2F0aW9u
Lgo+IC0tCj4gCj4gLS0tIFBhdGNoIFszXTogW1BBVENIIHYxNCAzLzVdIHB3bTogZHdjOiBhZGQg
b2YvcGxhdGZvcm0gc3VwcG9ydCAtLS0KPiBjb21taXQgYjQ0MTIzMWRlMmZjYzg5ZTQxODdiNjcy
YmRlMTkxOTYyMmFjNzM0Nwo+IEF1dGhvcjogWHV5YW5nIERvbmcgPGRvbmd4dXlhbmdAZXN3aW5j
b21wdXRpbmcuY29tPgo+IAo+IHB3bTogZHdjOiBhZGQgb2YvcGxhdGZvcm0gc3VwcG9ydAo+IAo+
IFRoaXMgY29tbWl0IGFkZHMgcGxhdGZvcm0gYW5kIE9GIGRldmljZSB0cmVlIHN1cHBvcnQgZm9y
IHRoZSBEZXNpZ25XYXJlIFBXTQo+IGNvbnRyb2xsZXIsIGVuYWJsaW5nIGl0cyB1c2UgaW4gbm9u
LVBDSSBzeXN0ZW1zLiBJdCBhbHNvIGltcGxlbWVudHMgcG9sYXJpdHkKPiBjb250cm9sIHVzaW5n
IGR1YWwgbG9hZCByZWdpc3RlcnMgYW5kIGFkZHMgcnVudGltZSBQTSBjYWxsYmFja3MgdG8gc2F2
ZSBhbmQKPiByZXN0b3JlIGhhcmR3YXJlIHN0YXRlLgo+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcHdtL3B3bS1kd2Mtb2YuYyBiL2RyaXZlcnMvcHdtL3B3bS1kd2Mtb2YuYwo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMDAuLmU5NmU1NTY5ZWI4MWUKPiA+
IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1kd2Mtb2YuYwo+IFsgLi4u
IF0KPiA+ICtzdGF0aWMgaW50IGR3Y19wd21fcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQo+ID4gK3sKPiBbIC4uLiBdCj4gPiArCWZvciAoaWR4ID0gMDsgaWR4IDwgY2hpcC0+bnB3
bTsgaWR4KyspIHsKPiA+ICsJCWR3Y19wd21fd3JpdGVsKGR3YywgZHdjLT5jdHhbaWR4XS5jbnQs
IERXQ19USU1fTERfQ05UKGlkeCkpOwo+ID4gKwkJZHdjX3B3bV93cml0ZWwoZHdjLCBkd2MtPmN0
eFtpZHhdLmNudDIsIERXQ19USU1fTERfQ05UMihpZHgpKTsKPiA+ICsJCWR3Y19wd21fd3JpdGVs
KGR3YywgZHdjLT5jdHhbaWR4XS5jdHJsLCBEV0NfVElNX0NUUkwoaWR4KSk7Cj4gCj4gW1NldmVy
aXR5OiBNZWRpdW1dCj4gRG9lcyB3cml0aW5nIHRoZSBzYXZlZCBjb250cm9sIHJlZ2lzdGVyIGRp
cmVjdGx5IGluIGR3Y19wd21fcnVudGltZV9yZXN1bWUoKQo+IHZpb2xhdGUgdGhlIGhhcmR3YXJl
IGluaXRpYWxpemF0aW9uIHNlcXVlbmNlPwo+IAoKSGkgU2FzaGlrbywKCk5vLCBiZWNhdXNlIGlm
IHRoZSBMb2FkIENvdW50IHJlZ2lzdGVyIGlzIHdyaXR0ZW4gYWZ0ZXIgdGhlIGNvbnRyb2zCoApy
ZWdpc3RlciwgaXQgd2lsbCBiZSB1cGRhdGVkIGFmdGVyIHRoZSB0aW1lciBpcyBlbmFibGVkLgoK
PiBUaGUgZHJpdmVyIG5vdGVzIGluIF9fZHdjX3B3bV9jb25maWd1cmVfdGltZXIoKSB0aGF0IHRo
ZSBzcGVjaWZpY2F0aW9uCj4gcmVxdWlyZXMgZGlzYWJsaW5nIHRoZSB0aW1lciwgcHJvZ3JhbW1p
bmcgaXQsIGFuZCB0aGVuIGVuYWJsaW5nIGl0Lgo+IAo+IFNpbmNlIGN0eFtpZHhdLmN0cmwgbWF5
IGhhdmUgdGhlIERXQ19USU1fQ1RSTF9FTiBiaXQgc2V0IGZyb20gd2hlbiB0aGUgZGV2aWNlCj4g
d2FzIGFjdGl2ZSwgZG9lcyB0aGlzIHNpbmdsZSB3cml0ZSBhdHRlbXB0IHRvIGNvbmZpZ3VyZSBh
bmQgZW5hYmxlIHRoZSB0aW1lcgo+IHNpbXVsdGFuZW91c2x5PyBDb3VsZCB0aGlzIGNhdXNlIHVu
cHJlZGljdGFibGUgYmVoYXZpb3IgdXBvbiByZXN1bWU/Cj4gCgpBbHRob3VnaCB0aGUgc2luZ2xl
IHdyaXRlIGF0dGVtcHRzIHRvIGNvbmZpZ3VyZSBhbmQgZW5hYmxlIHRoZSB0aW1lcsKgCnNpbXVs
dGFuZW91c2x5LCB0aGUgTG9hZCBDb3VudCByZWdpc3RlcnMgYXJlIHVwZGF0ZWQgYmVmb3JlIHRo
ZSB0aW1lciBpc8KgCmVuYWJsZWQuIFRoZXJlZm9yZSwgdGhpcyBhcHByb2FjaCB3aWxsIG5vdCBj
YXVzZSB1bnByZWRpY3RhYmxlIGJlaGF2aW9yLgoKQmVzdCByZWdhcmRzLApYdXlhbmcgRG9uZwoK
PiA+ICsJfQo+ID4gKwo+ID4gKwlyZXR1cm4gMDsKPiA+ICt9Cj4gCj4gLS0gCj4gU2FzaGlrbyBB
SSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNzMwMTExNDI1
LjE2ODAtMS1kb25neHV5YW5nQGVzd2luY29tcHV0aW5nLmNvbT9wYXJ0PTMK
