Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59973EC6B3;
	Mon, 27 Jul 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144356; cv=none; b=ivH6PUx5LF6TSpDhJmA6qjkGfRpfPKH8nfw7jYq5q5YzLYRY0E+8SvOzvqspsOgHWihjeeHPhsQDFYXXNcogb90n4IMb23IO0XpNVK0RKGPBwhJFXHKCHHn4Ws2WtDFMS5OJ1beb2OLDagDTsx8sZbgNk3N4ncs9bIwt5ftJRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144356; c=relaxed/simple;
	bh=blCXtiAqwjuch/OKpQCaCIHd9yxHMyNMG+E2/beYVBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sN1zi3MyXTl5iSIVeHaVr9UN45OyQgU1eax67OGXexP8wgUWq5aQSimbgfZ7Ckgzhh3Y47vMv1paBW7bvMV1SV9vlHl3CJrEjGH1ifCtg+U7KNwNJJQjCE05fWe3wMoIUHeCXDxjqJIK+BnWcQt8j3oObAngo3iMQ7+hdQ8DA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 27 Jul 2026 17:25:35 +0800 (GMT+08:00)
Date: Mon, 27 Jul 2026 17:25:35 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v13 3/5] pwm: dwc: add of/platform support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260724085715.9847C1F00A3F@smtp.kernel.org>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084346.1690-1-dongxuyang@eswincomputing.com>
 <20260724085715.9847C1F00A3F@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <46a18988.8bcd.19fa2e4dcc6.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaAPJGdqZkw3AA--.9273W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEBAmpmNx0dB
	wADs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIE1vZHVs
ZSBhdXRvbG9hZGluZyBmb3Igbm9uLU9GIHNldHVwcyB3aWxsIGZhaWwgZHVlIHRvIGEgbW9kdWxl
IGFsaWFzIG1pc21hdGNoLgo+IC0tCj4gCj4gLS0tIFBhdGNoIFszXTogW1BBVENIIHYxMyAzLzVd
IHB3bTogZHdjOiBhZGQgb2YvcGxhdGZvcm0gc3VwcG9ydCAtLS0KPiBjb21taXQgZWZhMzEwZjQ1
MWY4NDNhOGVkMmYwOTVkNmQ2ZDNjNDQzNTEwY2ExYQo+IEF1dGhvcjogWHV5YW5nIERvbmcgPGRv
bmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+IAo+IHB3bTogZHdjOiBhZGQgb2YvcGxhdGZv
cm0gc3VwcG9ydAo+IAo+IFRoaXMgY29tbWl0IGFkZHMgcGxhdGZvcm0gYW5kIE9GLWJhc2VkIHBy
b2Jpbmcgc3VwcG9ydCBmb3IgdGhlIGR3YyBQV00KPiBjb250cm9sbGVyLCBhbGxvd2luZyBpdCB0
byBiZSB1c2VkIGluIG5vbi1QQ0kgc3lzdGVtcy4gSXQgaW1wbGVtZW50cyBwb2xhcml0eQo+IGNv
bnRyb2wgdXNpbmcgdGhlIHRpbWVyJ3MgZHVhbCBsb2FkIHJlZ2lzdGVycyBhbmQgdXBkYXRlcyBj
bG9jayBhbmQgcnVudGltZQo+IFBNIHN0YXRlIG1hbmFnZW1lbnQuCj4gCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wd20vcHdtLWR3Yy1vZi5jIGIvZHJpdmVycy9wd20vcHdtLWR3Yy1vZi5jCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwMDAwMC4uNDk1NmRkMzZm
OTNhZAo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLWR3Yy1vZi5j
Cj4gCj4gWyAuLi4gXQo+IAo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGR3Y19w
d21fcGxhdF9kcml2ZXIgPSB7Cj4gPiArCS5kcml2ZXIgPSB7Cj4gPiArCQkubmFtZSA9ICJkd2Mt
cHdtIiwKPiA+ICsJCS5wbSA9IHBtX3B0cigmZHdjX3B3bV9wbV9vcHMpLAo+ID4gKwkJLm9mX21h
dGNoX3RhYmxlID0gZHdjX3B3bV9kdF9pZHMsCj4gPiArCX0sCj4gPiArCS5wcm9iZSA9IGR3Y19w
d21fcGxhdF9wcm9iZSwKPiA+ICsJLnJlbW92ZSA9IGR3Y19wd21fcGxhdF9yZW1vdmUsCj4gPiAr
fTsKPiA+ICsKPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGR3Y19wd21fcGxhdF9kcml2ZXIp
Owo+ID4gKwo+ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06ZHdjLXB3bS1vZiIpOwo+IAo+IFtT
ZXZlcml0eTogTWVkaXVtXQo+IERvZXMgdGhpcyBtb2R1bGUgYWxpYXMgbWlzbWF0Y2ggcHJldmVu
dCBhdXRvbWF0aWMgbW9kdWxlIGxvYWRpbmcgb24gbm9uLU9GCj4gc2V0dXBzPwo+IAo+IFRoZSBw
bGF0Zm9ybSBkcml2ZXIgcmVnaXN0ZXJzIGl0cyBuYW1lIGFzICJkd2MtcHdtIiwgd2hpY2ggbWVh
bnMgYSBzeXN0ZW0KPiB3aXRob3V0IERldmljZSBUcmVlIHdpbGwgZW1pdCBhIHVldmVudCB3aXRo
IE1PREFMSUFTPXBsYXRmb3JtOmR3Yy1wd20uIFNpbmNlCj4gdGhlIHByb3ZpZGVkIE1PRFVMRV9B
TElBUyBpcyAicGxhdGZvcm06ZHdjLXB3bS1vZiIsIHVkZXYgd2lsbCBsaWtlbHkgZmFpbCB0bwo+
IGZpbmQgYW5kIGxvYWQgdGhpcyBtb2R1bGUgYXV0b21hdGljYWxseS4KPiAKCkhpIFNhc2hpa28s
CgpSZW1vdmUgTU9EVUxFX0FMSUFTKCkgaW4gdGhlIG5leHQgdmVyc2lvbi4KCkJlc3QgcmVnYXJk
cywKWHV5YW5nIERvbmcKCj4gPiArTU9EVUxFX0FVVEhPUigiQmVuIERvb2tzIDxiZW4uZG9va3NA
Y29kZXRoaW5rLmNvLnVrPiIpOwo+ID4gK01PRFVMRV9ERVNDUklQVElPTigiRGVzaWduV2FyZSBQ
V00gQ29udHJvbGxlciIpOwo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKPiAKPiAtLSAKPiBT
YXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3
MjQwODQxNTMuMTQ3My0xLWRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tP3BhcnQ9Mwo=
