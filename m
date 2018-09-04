Return-Path: <Christoph.Vogtlaender@sigma-surface-science.com>
From: =?iso-8859-1?Q?Christoph_Vogtl=E4nder?=
	<Christoph.Vogtlaender@sigma-surface-science.com>
Subject: [PATCH] pwm: tiehrpwm: Fix disabling of output of PWMs
Date: Tue, 4 Sep 2018 16:04:37 +0000
Message-ID: <5536af84a17647d1b30b4cdc0d19e1af@SSSDEEX.i.sigma-surface-science.com>
Content-Language: de-DE
Content-Type: multipart/mixed;
	boundary="_002_5536af84a17647d1b30b4cdc0d19e1afSSSDEEXisigmasurfacesci_"
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vignesh R <vigneshr@ti.com>, =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= <Christoph.Vogtlaender@sigma-surface-science.com>

--_002_5536af84a17647d1b30b4cdc0d19e1afSSSDEEXisigmasurfacesci_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

pwm-tiehrpwm driver disables PWM output by putting it in low output
state via active AQCSFRC register in ehrpwm_pwm_disable(). But, the
AQCSFRC shadow register is not updated. Therefore, when shadow AQCSFRC
register is re-enabled in ehrpwm_pwm_enable() (say to enable second PWM
output), previous settings are lost as shadow register value is loaded
into active register. This results in things like PWMA getting enabled
automatically, when PWMB is enabled and vice versa. Fix this by
updating AQCSFRC shadow register as well during ehrpwm_pwm_disable().


This is a follow up to commit 38dabd91ff0bde33352ca3cc65ef515599b77a05.
It must be made sure that immediate mode is not already set when the shadow
register value is set in ehrpwm_pwm_disable(). Otherwise modifications to t=
he
action-qualifier continuous S/W force register will be done in the active r=
egister.
This may happen when both channels get disabled. Only the first channel sta=
te
will be recorded as disabled in the shadow register. When enabling the firs=
t
channel again, the second channel would be enabled as well.
Setting RLDCSF to zero, first. This ensures that the shadow register is upd=
ated
as desired.

Please CC me in replies as I'm not a member of the list.
--
Best Regards
Christoph Vogtl=E4nder

SIGMA Surface Science GmbH
Software Development
Configuration Manager

Tel: +49 (0)6128/85905-190
Fax: +49 (0)6128/85905-200

Idsteiner Str. 78
D-65232 Taunusstein


Sigma Surface Science GmbH, Idsteiner Str. 78, 65232 Taunusstein. Amtsgeric=
ht Wiesbaden, HRB 27422. Gesch=E4ftsf=FChrer: Norbert Nold

--_002_5536af84a17647d1b30b4cdc0d19e1afSSSDEEXisigmasurfacesci_
Content-Type: application/octet-stream;
	name="0002-pwm-tiehrpwm-Fix-disabling-of-output-of-PWMs.patch"
Content-Description: 0002-pwm-tiehrpwm-Fix-disabling-of-output-of-PWMs.patch
Content-Disposition: attachment;
	filename="0002-pwm-tiehrpwm-Fix-disabling-of-output-of-PWMs.patch";
	size=1460; creation-date="Tue, 04 Sep 2018 16:02:51 GMT";
	modification-date="Tue, 04 Sep 2018 16:00:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZTIwZmM4NWQyMGNlMWY0MmI2MzdlMWE4OGZmYzIyZDkxNDU3NTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Q2hyaXN0b3BoPTIwVm9ndGw9QzM9QTRuZGVy
Pz0KIDxjLnZvZ3RsYWVuZGVyQHNpZ21hLXN1cmZhY2Utc2NpZW5jZS5jb20+CkRhdGU6IFR1ZSwg
NCBTZXAgMjAxOCAxNzowMDoxOCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIHB3bTogdGllaHJwd206
IEZpeCBkaXNhYmxpbmcgb2Ygb3V0cHV0IG9mIFBXTXMKCnB3bS10aWVocnB3bSBkcml2ZXIgZGlz
YWJsZXMgUFdNIG91dHB1dCBieSBwdXR0aW5nIGl0IGluIGxvdyBvdXRwdXQKc3RhdGUgdmlhIGFj
dGl2ZSBBUUNTRlJDIHJlZ2lzdGVyIGluIGVocnB3bV9wd21fZGlzYWJsZSgpLiBCdXQsIHRoZQpB
UUNTRlJDIHNoYWRvdyByZWdpc3RlciBpcyBub3QgdXBkYXRlZC4gVGhlcmVmb3JlLCB3aGVuIHNo
YWRvdyBBUUNTRlJDCnJlZ2lzdGVyIGlzIHJlLWVuYWJsZWQgaW4gZWhycHdtX3B3bV9lbmFibGUo
KSAoc2F5IHRvIGVuYWJsZSBzZWNvbmQgUFdNCm91dHB1dCksIHByZXZpb3VzIHNldHRpbmdzIGFy
ZSBsb3N0IGFzIHNoYWRvdyByZWdpc3RlciB2YWx1ZSBpcyBsb2FkZWQKaW50byBhY3RpdmUgcmVn
aXN0ZXIuIFRoaXMgcmVzdWx0cyBpbiB0aGluZ3MgbGlrZSBQV01BIGdldHRpbmcgZW5hYmxlZAph
dXRvbWF0aWNhbGx5LCB3aGVuIFBXTUIgaXMgZW5hYmxlZCBhbmQgdmljZSB2ZXJzYS4gRml4IHRo
aXMgYnkKdXBkYXRpbmcgQVFDU0ZSQyBzaGFkb3cgcmVnaXN0ZXIgYXMgd2VsbCBkdXJpbmcgZWhy
cHdtX3B3bV9kaXNhYmxlKCkuCi0tLQogZHJpdmVycy9wd20vcHdtLXRpZWhycHdtLmMgfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
d20vcHdtLXRpZWhycHdtLmMgYi9kcml2ZXJzL3B3bS9wd20tdGllaHJwd20uYwppbmRleCA0Njdj
Y2QxLi43Njg4YjhhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tdGllaHJwd20uYworKysg
Yi9kcml2ZXJzL3B3bS9wd20tdGllaHJwd20uYwpAQCAtMzgzLDYgKzM4Myw4IEBAIHN0YXRpYyB2
b2lkIGVocnB3bV9wd21fZGlzYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21f
ZGV2aWNlICpwd20pCiAJfQogCiAJLyogVXBkYXRlIHNoYWRvdyByZWdpc3RlciBmaXJzdCBiZWZv
cmUgbW9kaWZ5aW5nIGFjdGl2ZSByZWdpc3RlciAqLworCWVocnB3bV9tb2RpZnkocGMtPm1taW9f
YmFzZSwgQVFTRlJDLCBBUVNGUkNfUkxEQ1NGX01BU0ssCisJCQlBUVNGUkNfUkxEQ1NGX1pSTyk7
CiAJZWhycHdtX21vZGlmeShwYy0+bW1pb19iYXNlLCBBUUNTRlJDLCBhcWNzZnJjX21hc2ssIGFx
Y3NmcmNfdmFsKTsKIAkvKgogCSAqIENoYW5nZXMgdG8gaW1tZWRpYXRlIGFjdGlvbiBvbiBBY3Rp
b24gUXVhbGlmaWVyLiBUaGlzIHB1dHMKLS0gCjIuNy40Cgo=

--_002_5536af84a17647d1b30b4cdc0d19e1afSSSDEEXisigmasurfacesci_--
