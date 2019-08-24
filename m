From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 1/3] pwm: bcm2835: suppress error message for invalid
 period_ns
Date: Sat, 24 Aug 2019 16:09:46 +0200
Message-ID: <1566655788-24949-2-git-send-email-wahrenst@gmx.net>
References: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566655788-24949-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

VGhlIFBXTSBjb25maWcgY2FuIGJlIHRyaWdnZXJlZCB2aWEgc3lzZnMsIHNvIHdlIGJldHRlciBz
dXBwcmVzcyB0aGUKZXJyb3IgbWVzc2FnZSBpbiBjYXNlIG9mIGFuIGludmFsaWQgcGVyaW9kIHRv
IGF2b2lkIGtlcm5lbCBsb2cgc3BhbW1pbmcuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gV2FocmVu
IDx3YWhyZW5zdEBnbXgubmV0PgpBY2tlZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5l
LWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tYmNtMjgzNS5jIHwg
NSArLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1iY20yODM1LmMgYi9kcml2ZXJzL3B3bS9wd20t
YmNtMjgzNS5jCmluZGV4IGY2ZmUwYjkuLjUyNzYzMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdt
L3B3bS1iY20yODM1LmMKKysrIGIvZHJpdmVycy9wd20vcHdtLWJjbTI4MzUuYwpAQCAtNzIsMTEg
KzcyLDggQEAgc3RhdGljIGludCBiY20yODM1X3B3bV9jb25maWcoc3RydWN0IHB3bV9jaGlwICpj
aGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLAoKIAlzY2FsZXIgPSBESVZfUk9VTkRfQ0xPU0VT
VChOU0VDX1BFUl9TRUMsIHJhdGUpOwoKLQlpZiAocGVyaW9kX25zIDw9IE1JTl9QRVJJT0QpIHsK
LQkJZGV2X2VycihwYy0+ZGV2LCAicGVyaW9kICVkIG5vdCBzdXBwb3J0ZWQsIG1pbmltdW0gJWRc
biIsCi0JCQlwZXJpb2RfbnMsIE1JTl9QRVJJT0QpOworCWlmIChwZXJpb2RfbnMgPD0gTUlOX1BF
UklPRCkKIAkJcmV0dXJuIC1FSU5WQUw7Ci0JfQoKIAl3cml0ZWwoRElWX1JPVU5EX0NMT1NFU1Qo
ZHV0eV9ucywgc2NhbGVyKSwKIAkgICAgICAgcGMtPmJhc2UgKyBEVVRZKHB3bS0+aHdwd20pKTsK
LS0KMi43LjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
