From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: enable PWM driver
Date: Thu, 10 Jan 2019 21:19:34 +0100
Message-ID: <20190110201934.4105-3-u.kleine-koenig@pengutronix.de>
References: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
 <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

V2hpbGUgdGhlcmUgaXMgbm8gbWFpbmxpbmUgYm9hcmQgdGhhdCBtYWtlcyB1c2Ugb2YgdGhlIFBX
TSBzdGlsbCBlbmFibGUgdGhlCmRyaXZlciBmb3IgaXQgdG8gaW5jcmVhc2UgY29tcGlsZSB0ZXN0
IGNvdmVyYWdlLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtv
ZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9jb25maWdzL2lteF92NF92NV9kZWZj
b25maWcgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y0X3Y1X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZp
Z3MvaW14X3Y0X3Y1X2RlZmNvbmZpZwppbmRleCA4NjYxZGQ5YjA2NGEuLmIzN2Y4ZTY3NWU0MCAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vY29uZmlncy9pbXhfdjRfdjVfZGVmY29uZmlnCisrKyBiL2Fy
Y2gvYXJtL2NvbmZpZ3MvaW14X3Y0X3Y1X2RlZmNvbmZpZwpAQCAtMTcwLDYgKzE3MCw5IEBAIENP
TkZJR19JTVhfU0RNQT15CiAjIENPTkZJR19JT01NVV9TVVBQT1JUIGlzIG5vdCBzZXQKIENPTkZJ
R19JSU89eQogQ09ORklHX0ZTTF9NWDI1X0FEQz15CitDT05GSUdfUFdNPXkKK0NPTkZJR19QV01f
SU1YMT15CitDT05GSUdfUFdNX0lNWDI3PXkKIENPTkZJR19FWFQ0X0ZTPXkKICMgQ09ORklHX0RO
T1RJRlkgaXMgbm90IHNldAogQ09ORklHX1ZGQVRfRlM9eQotLSAKMi4yMC4xCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
