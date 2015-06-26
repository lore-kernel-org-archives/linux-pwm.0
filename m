From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [v3 0/7] Crystalcove (CRC) PMIC based panel and pwm
	control
Date: Fri, 26 Jun 2015 14:32:03 +0530
Message-ID: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>, Linus Walleij <linus.walleij@linaro.org>, varkabhadram@gmail.com, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

SGksCk5leHQgdXBkYXRlIG9mIHRoZSBzZXJpZXMgcmV2aWV3ZWQgYXQgCmh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE1LzYvMjIvMTU1CgpNYWpvciBjaGFuZ2VzIGFyZSBmZXcgcmV2aWV3IGNvbW1l
bnRzIGZyb20gVmFya2EgYW5kIFZpbGxlIGJlaW5nIGFkZHJlc3NlZC4gQWxzbyBleGNlcHQKZm9y
IGludGVsLWdmeCBwYXRjaGVzLCBhbGwgcGF0Y2hlcyByZXZpZXNpb24gaGlzdG9yeSBpcyBtb3Zl
ZCBvdXQgb2YgY29tbWl0IG1lc3NhZ2UuCgpIb3BlIHRoaXMgc2VyaWVzIGZpbmFsbHkgZmluZHMg
aXRzIG1hcmsuCgpSZWdhcmRzClNob2JoaXQKClNob2JoaXQgS3VtYXIgKDcpOgogIGdwaW9saWI6
IEFkZCBzdXBwb3J0IGZvciByZW1vdmluZyByZWdpc3RlcmVkIGNvbnN1bWVyIGxvb2t1cCB0YWJs
ZQogIG1mZDogaW50ZWxfc29jX3BtaWNfY29yZTogQWRkIGxvb2t1cCB0YWJsZSBmb3IgUGFuZWwg
Q29udHJvbCBhcyBHUElPCiAgICBzaWduYWwKICBtZmQ6IGludGVsX3NvY19wbWljX2NyYzogQWRk
IFBXTSBjZWxsIGRldmljZSBmb3IgQ3J5c3RhbGNvdmUgUE1JQwogIG1mZDogaW50ZWxfc29jX3Bt
aWNfY29yZTogQUREIFBXTSBsb29rdXAgdGFibGUgZm9yIENSQyBQTUlDIGJhc2VkIFBXTQogIHB3
bTogY3JjOiBBZGQgQ3J5c3RhbGNvdmUgKENSQykgUFdNIGRyaXZlcgogIGRybS9pOTE1OiBVc2Ug
dGhlIENSQyBncGlvIGZvciBwYW5lbCBlbmFibGUvZGlzYWJsZQogIGRybS9pOTE1OiBCYWNrbGln
aHQgY29udHJvbCB1c2luZyBDUkMgUE1JQyBiYXNlZCBQV00gZHJpdmVyCgogZHJpdmVycy9ncGlv
L2dwaW9saWIuYyAgICAgICAgICAgICB8ICAxMyArKysrCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9p
bnRlbF9iaW9zLmggIHwgICA3ICsrCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kcnYuaCAg
IHwgICA0ICsrCiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pbnRlbF9kc2kuYyAgIHwgIDM3ICsrKysr
KysrKy0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RzaS5oICAgfCAgIDMgKwogZHJpdmVy
cy9ncHUvZHJtL2k5MTUvaW50ZWxfcGFuZWwuYyB8ICA5NCArKysrKysrKysrKysrKysrKysrKysr
LS0KIGRyaXZlcnMvbWZkL2ludGVsX3NvY19wbWljX2NvcmUuYyAgfCAgMjkgKysrKysrKysKIGRy
aXZlcnMvbWZkL2ludGVsX3NvY19wbWljX2NyYy5jICAgfCAgIDMgKwogZHJpdmVycy9wd20vS2Nv
bmZpZyAgICAgICAgICAgICAgICB8ICAgNyArKwogZHJpdmVycy9wd20vTWFrZWZpbGUgICAgICAg
ICAgICAgICB8ICAgMSArCiBkcml2ZXJzL3B3bS9wd20tY3JjLmMgICAgICAgICAgICAgIHwgMTQz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvZ3Bp
by9tYWNoaW5lLmggICAgICAgfCAgIDEgKwogMTIgZmlsZXMgY2hhbmdlZCwgMzM1IGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wd20vcHdt
LWNyYy5jCgotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50
ZWwtZ2Z4Cg==
