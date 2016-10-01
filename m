From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2 1/6] pwm: print error messages with pr_err() instead of
 pr_debug()
Date: Sat, 1 Oct 2016 15:42:30 +0530
Message-ID: <20161001101235.24598-2-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, thierry.reding@gmail.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

RnJvbTogTG90aGFyIFdhc3NtYW5uIDxMV0BLQVJPLWVsZWN0cm9uaWNzLmRlPgoKTWFrZSB0aGUg
bWVzc2FnZXMgdGhhdCBhcmUgcHJpbnRlZCBpbiBjYXNlIG9mIGZhdGFsIGVycm9ycyBhY3R1YWxs
eSB2aXNpYmxlIHRvCnRoZSB1c2VyIHdpdGhvdXQgaGF2aW5nIHRvIHJlY29tcGlsZSB0aGUgZHJp
dmVyIHdpdGggZGVidWdnaW5nIGVuYWJsZWQuCgpTaWduZWQtb2ZmLWJ5OiBMb3RoYXIgV2HDn21h
bm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNpZ25lZC1vZmYtYnk6IEJodXZhbmNoYW5kcmEg
RFYgPGJodXZhbmNoYW5kcmEuZHZAdG9yYWRleC5jb20+Ci0tLQogZHJpdmVycy9wd20vY29yZS5j
IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL2NvcmUuYyBiL2RyaXZlcnMvcHdtL2NvcmUuYwpp
bmRleCAwZGJkMjllLi4xOTUzNzNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9jb3JlLmMKKysr
IGIvZHJpdmVycy9wd20vY29yZS5jCkBAIC02NjEsMTMgKzY2MSwxMyBAQCBzdHJ1Y3QgcHdtX2Rl
dmljZSAqb2ZfcHdtX2dldChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBjb25zdCBjaGFyICpjb25f
aWQpCiAJZXJyID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MobnAsICJwd21zIiwgIiNwd20t
Y2VsbHMiLCBpbmRleCwKIAkJCQkJICZhcmdzKTsKIAlpZiAoZXJyKSB7Ci0JCXByX2RlYnVnKCIl
cygpOiBjYW4ndCBwYXJzZSBcInB3bXNcIiBwcm9wZXJ0eVxuIiwgX19mdW5jX18pOworCQlwcl9l
cnIoIiVzKCk6IGNhbid0IHBhcnNlIFwicHdtc1wiIHByb3BlcnR5XG4iLCBfX2Z1bmNfXyk7CiAJ
CXJldHVybiBFUlJfUFRSKGVycik7CiAJfQogCiAJcGMgPSBvZl9ub2RlX3RvX3B3bWNoaXAoYXJn
cy5ucCk7CiAJaWYgKElTX0VSUihwYykpIHsKLQkJcHJfZGVidWcoIiVzKCk6IFBXTSBjaGlwIG5v
dCBmb3VuZFxuIiwgX19mdW5jX18pOworCQlwcl9lcnIoIiVzKCk6IFBXTSBjaGlwIG5vdCBmb3Vu
ZFxuIiwgX19mdW5jX18pOwogCQlwd20gPSBFUlJfQ0FTVChwYyk7CiAJCWdvdG8gcHV0OwogCX0K
LS0gCjIuOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
