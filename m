Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A523A562;
	Fri, 31 Jul 2026 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480080; cv=none; b=XOHbvFJqd8gs2dIDicPJzxuN4xJlLgFNEsLLXPkwJiMCEafEMJc3E2YSzEE6zdTf3L+YArbc1MnbHNmQMNfFbrJusoRkuurPHGQJXhAwxWJPy6aHNUzqutUKLh9Elb+JccnH8eePWX0Zij1nSijEnybIl8Ns8LcClFtOrKQlmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480080; c=relaxed/simple;
	bh=lyr7c2H0MZlmbK9Vbrvow2o05mK8vYnyFKtJVx8ijgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mEmPcTfbXItcijRHUGIoo+cB1DbtWBAg65TEl6PWfNfuCjZZo7Hp7coMwY7q0pyhKHdMrZaVS7wtSglkUmN2SwW6WY4lUtQPBnUvW25OLhmO0tIbRRCNaS7K5CIeSdEhEq6GfJZGcmGZquLEYFE+nU7qS0b8rA+EeY7vgYC6s8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 31 Jul 2026 14:41:00 +0800 (GMT+08:00)
Date: Fri, 31 Jul 2026 14:41:00 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v14 2/5] dt-bindings: pwm: dwc: Add eswin compatible
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260730112958.9ED571F00A3A@smtp.kernel.org>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
 <20260730111534.1834-1-dongxuyang@eswincomputing.com>
 <20260730112958.9ED571F00A3A@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4dfe481d.8eec.19fb6e79ed6.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPJ98Q2xqDPA3AA--.8297W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQEFAmprfKgUQ
	wAAsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBm
b3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIFRoZSBj
b25kaXRpb25hbCBzY2hlbWEgZm9yIGBlc3dpbixlaWM3NzAwLXB3bWAgZmFpbHMgdG8gY29uc3Ry
YWluIHRoZSBgcmVzZXRzYCBwcm9wZXJ0eSB0byBhIG1heGltdW0gb2YgMSBpdGVtLgo+IC0tCj4g
Cj4gLS0tIFBhdGNoIFsyXTogW1BBVENIIHYxNCAyLzVdIGR0LWJpbmRpbmdzOiBwd206IGR3Yzog
QWRkIGVzd2luIGNvbXBhdGlibGUgLS0tCj4gY29tbWl0IDgwNGMzNGFmZmZlODZkNGEzZmYyNTMy
MDFiNjQ3MGU3MDBmMWFmNDcKPiBBdXRob3I6IFh1eWFuZyBEb25nIDxkb25neHV5YW5nQGVzd2lu
Y29tcHV0aW5nLmNvbT4KPiAKPiBkdC1iaW5kaW5nczogcHdtOiBkd2M6IEFkZCBlc3dpbiBjb21w
YXRpYmxlCj4gCj4gVGhpcyBjb21taXQgYWRkcyB0aGUgZXN3aW4sZWljNzcwMC1wd20gY29tcGF0
aWJsZSBzdHJpbmcgdG8gdGhlCj4gc25wcyxkdy1hcGItdGltZXJzLXB3bTIgYmluZGluZy4gVGhl
IEVJQzc3MDAgaW50ZWdyYXRlcyB0aGlzIElQIGJ1dCByZXF1aXJlcwo+IGV4YWN0bHkgb25lIGNv
bWJpbmVkIHJlc2V0IGxpbmUgaW5zdGVhZCBvZiB1cCB0byB0d28gaW5kZXBlbmRlbnQgbGluZXMu
Cj4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3
bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiBpbmRleCAxZjlk
NzJmOWYzNTkwLi44N2E1NmZmZWQwOWQ5IDEwMDY0NAo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3NucHMsZHctYXBiLXRp
bWVycy1wd20yLnlhbWwKPiBbIC4uLiBdCj4gPiBAQCAtNjQsNiArNjQsMjkgQEAgcmVxdWlyZWQ6
Cj4gPiAgICAtIGNsb2Nrcwo+ID4gICAgLSBjbG9jay1uYW1lcwo+ID4gIAo+ID4gK2FsbE9mOgo+
ID4gKyAgLSAkcmVmOiBwd20ueWFtbCMKPiA+ICsKPiA+ICsgIC0gaWY6Cj4gPiArICAgICAgcHJv
cGVydGllczoKPiA+ICsgICAgICAgIGNvbXBhdGlibGU6Cj4gPiArICAgICAgICAgIGNvbnRhaW5z
Ogo+ID4gKyAgICAgICAgICAgIGNvbnN0OiBlc3dpbixlaWM3NzAwLXB3bQo+ID4gKyAgICB0aGVu
Ogo+ID4gKyAgICAgIHByb3BlcnRpZXM6Cj4gPiArICAgICAgICByZXNldHM6Cj4gPiArICAgICAg
ICAgIGl0ZW1zOgo+ID4gKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IENvbWJpbmVkIEFQQiBp
bnRlcmZhY2UgYW5kIHRpbWVyIGxvZ2ljIHJlc2V0Cj4gCj4gW1NldmVyaXR5OiBNZWRpdW1dCj4g
SXMgaXQgcG9zc2libGUgZm9yIGEgZGV2aWNlIHRyZWUgdG8gcGFzcyB2YWxpZGF0aW9uIHdpdGgg
dHdvIHJlc2V0cyBmb3IgdGhpcwo+IGNvbXBhdGlibGUsIGRlc3BpdGUgdGhlIGludGVudGlvbiBp
biB0aGUgY29tbWl0IG1lc3NhZ2U/Cj4gCgpIaSBTYXNoaWtvLAoKQmVjYXVzZSB3ZSBhZGRlZCBh
biBleGFtcGxlIGZvciBvbmUgcmVzZXQuCklmIHlvdSBhZGQgdHdvIHJlc2V0cyBmb3IgZXN3aW4s
ZWljNzcwMC1wd20gaW4gYSBkZXZpY2UgdHJlZSwgcnVubmluZ8KgCiJtYWtlIGR0YnNfY2hlY2si
IHdpbGwgcmVwb3J0IHRoYXQgdGhlIHJlc2V0cyBwcm9wZXJ0eSBpcyB0b28gbG9uZy4KCj4gQmVj
YXVzZSB0aGUgdG9wLWxldmVsIHJlc2V0cyBwcm9wZXJ0eSBpbXBsaWNpdGx5IGFsbG93cyB1cCB0
byAyIGl0ZW1zLAo+IG92ZXJyaWRpbmcgdGhlIGl0ZW1zIGxpc3QgaGVyZSB3aXRoIGEgc2luZ2xl
IGVsZW1lbnQgZG9lc24ndCBhdXRvbWF0aWNhbGx5Cj4gcmVkdWNlIHRoZSBtYXhpbXVtIGFsbG93
ZWQgaXRlbXMuCj4gCj4gU2hvdWxkIG1heEl0ZW1zOiAxIGJlIGFkZGVkIGV4cGxpY2l0bHkgaW4g
dGhpcyBibG9jayBhbG9uZ3NpZGUgaXRlbXM/Cj4gCgpJZiB3ZSBhZGQgIm1heEl0ZW1zOiAxIiwg
cnVubmluZyAibWFrZSBkdF9iaW5kaW5nX2NoZWNrIiB3aWxsIHJlcG9ydCB0aGF0wqAKbWF4SXRl
bXMgaXMgbm90IG5lZWRlZCB3aGVuIGFuIGl0ZW1zIGxpc3QgaXMgYWxyZWFkeSBwcmVzZW50LgoK
QmVzdCByZWdhcmRzLApYdXlhbmcgRG9uZwoKPiAtLSAKPiBTYXNoaWtvIEFJIHJldmlldyDCtyBo
dHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA3MzAxMTE0MjUuMTY4MC0xLWRvbmd4
dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tP3BhcnQ9Mgo=
